import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import com.intellij.codeInsight.highlighting.HighlightManager;
import com.intellij.ide.plugins.IdeaPluginDescriptor;
import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.actionSystem.Presentation;
import com.intellij.openapi.command.CommandProcessor;
import com.intellij.openapi.editor.colors.EditorColors;
import com.intellij.openapi.editor.markup.HighlighterLayer;
import com.intellij.openapi.editor.markup.HighlighterTargetArea;
import com.intellij.openapi.editor.markup.RangeHighlighter;
import com.intellij.openapi.editor.markup.TextAttributes;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.DumbService;
import com.intellij.openapi.project.IndexNotReadyException;
import com.intellij.openapi.ui.Messages;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

import java.awt.*;
import java.io.File;

import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.command.WriteCommandAction;
//import com.intellij.openapi.editor.Document;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.SelectionModel;
import com.intellij.openapi.editor.colors.EditorColorsScheme;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.TextRange;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;

public class LoopInvHandler extends AnAction {

    HashSet<Integer> tbdisplayed = new HashSet<>();
    LoopInfo li;
    boolean fix;
    public void update(final AnActionEvent e) {
        //Get required data keys
        final Project project = e.getData(CommonDataKeys.PROJECT);
        final Editor editor = e.getData(CommonDataKeys.EDITOR);
        final Presentation presentation = e.getPresentation();
        //Set visibility only in case of existing project and editor
        presentation.setVisible((project != null && editor != null && editor.getSelectionModel().hasSelection()));
        presentation.setEnabled(e.getProject() != null && editor != null && e.getData(CommonDataKeys.PSI_FILE) != null);
    }

    public void changeDocument(LoopInfo lf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        //int startLine = lf.getStart();
        //int endLine = lf.getEnd();
        int line2change = lf.getStatement();
        System.out.println("In changeDocument function");
        if (line2change <= 0){
            System.out.println("ERROR: This can't be a loop");
            return;
        }
        int indlend = d.getLineEndOffset(line2change - 1);
        int indlstart = d.getLineStartOffset(line2change - 1);
        String expr = editor.getDocument().getText(new TextRange(indlstart, indlend)).trim();
        String error_msg = expr + " is a loop invariant query\nFix: hoist " + expr;
        Util.addTooltips( editor,  error_msg,  line2change);

        System.out.println("Got start and end offsets");

        try {

            TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                    editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
            editor.getMarkupModel().addRangeHighlighter(indlstart, indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            ex.printStackTrace();
            System.exit(1);
        }

        tbdisplayed.add(line2change);

    }
    public void fixDocument(LoopInfo lf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        //int startLine = lf.getStart();
        //int endLine = lf.getEnd();
        int line2change = lf.getStatement();
        System.out.println("In changeDocument function");
        if (line2change <= 0){
            System.out.println("ERROR: This can't be a loop");
            return;
        }
        int indlend = d.getLineEndOffset(line2change - 1);
        int indlstart = d.getLineStartOffset(line2change - 1);
        int insertoffset = d.getLineStartOffset(lf.getStart() - 1);

        String expr = editor.getDocument().getText(new TextRange(indlstart, indlend)).trim();

        try {
            d.deleteString(indlstart, indlend);
            d.insertString(insertoffset, expr + "\n");

        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            ex.printStackTrace();
            System.exit(1);
        }
        tbdisplayed.add(line2change);
    }

    public void actionPerformed(final AnActionEvent anActionEvent) {
        //Get all the required data from data keys
        final Editor editor = FileEditorManager.getInstance(anActionEvent.getProject()).getSelectedTextEditor();
        if (editor == null){
            Messages.showMessageDialog("Editor Retrieval Failure. Try again.", "Failure", Messages.getErrorIcon());
            return;
        }
        final Project project = anActionEvent.getData(CommonDataKeys.PROJECT);
        if (project == null){
            Messages.showMessageDialog("Project Retrieval Failure. Try again.", "Failure", Messages.getErrorIcon());
            return;
        }
        //final String path = project.getProjectFilePath();
        //Given: editor and project. Want: document user is currently looking at.
        final VirtualFile path2 = project.getWorkspaceFile();
        if (path2 == null){
            Messages.showMessageDialog("Project Retrieval Failure. Try again.", "Failure", Messages.getErrorIcon());
            return;
        }

        //Access document, caret, and selection
        final com.intellij.openapi.editor.Document document = editor.getDocument();
        VirtualFile vf = FileDocumentManager.getInstance().getFile(document);
        if (vf == null){
            Messages.showMessageDialog("Invalid document: either does not exist, or is too large.", "Failure", Messages.getErrorIcon());
        }

        String fname = vf.getName();


        //final int start = selectionModel.getSelectionStart();
        //final int end = selectionModel.getSelectionEnd();
        //New instance of Runnable to make a replacement
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Util.removeHighlighters(project);
                String results_path = Util.getRP(project);
                File file = new File(results_path + "loop_invariant.xml");
                if(li != null){
                    if(fix){
                        fixDocument(li, document, project, editor);
                        fix = false;
                    }
                    else {
                        changeDocument(li, document, project, editor);
                    }
                }
                else{
//                    List<LoopInfo> loopInfo = Util.extractLIInfo(file);
//                    for (int temp = 0; temp < loopInfo.size(); temp++){
//                        LoopInfo curL = loopInfo.get(temp);
//                        System.out.println(curL.getFilename());
//                        System.out.println(fname);
//                        if (curL.getFilename().contains(fname)){
//                            System.out.println("If case taken");
//                            changeDocument(curL, document, project, editor);
//
//                        }
//                    }
                }
            }

        };

        WriteCommandAction.runWriteCommandAction(project,runnable);
        //LoopErrorMenu lem = new LoopErrorMenu(tbdisplayed, anActionEvent);
        //lem.setVisible(true);

    }
}