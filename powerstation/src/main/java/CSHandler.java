import com.intellij.ide.plugins.IdeaPluginDescriptor;
import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.actionSystem.Presentation;
import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.colors.EditorColors;
import com.intellij.openapi.editor.markup.HighlighterLayer;
import com.intellij.openapi.editor.markup.HighlighterTargetArea;
import com.intellij.openapi.editor.markup.TextAttributes;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiFile;
import com.intellij.psi.impl.file.impl.FileManager;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class CSHandler extends AnAction {
    CSInfo cs;
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

    public void changeDocument(CSInfo csinfo, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        String expression = csinfo.getExpression();
        List<Statement> stms = csinfo.getExprs();
        System.out.println("In changeDocument function");
        for(int i = 0; i < stms.size(); i ++){
            Statement stm = stms.get(i);
            String filename =  stm.getFilename();
            int loc = stm.getStatement();
            int indlend = d.getLineEndOffset(loc - 1);
            int indlstart = d.getLineStartOffset(loc - 1);
            //TODO maybe in different files
            try {

                TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                        editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                editor.getMarkupModel().addRangeHighlighter(indlstart, indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                String error_msg = expression + " is the shared subexpression";
                Util.addTooltips( editor,  error_msg,  loc);

            }catch (ExceptionInInitializerError ex){
                System.out.println("Text Attributes is null");
                Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
                System.exit(1);
            }

        }


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
        final String actualpath = path2.getCanonicalPath();
        //Access document, caret, and selection
        final com.intellij.openapi.editor.Document document = editor.getDocument();
        VirtualFile vf = FileDocumentManager.getInstance().getFile(document);
        if (vf == null){
            Messages.showMessageDialog("Invalid document: either does not exist, or is too large.", "Failure", Messages.getErrorIcon());
        }

        String fname = vf.getName();
        //final SelectionModel selectionModel = editor.getSelectionModel();

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                String results_path;
                results_path = Util.getRP(project);
                File file = new File(results_path + "common_subexpression.xml");
                Util.removeHighlighters(project);

                if(cs != null){
                    changeDocument(cs, document, project, editor);
                }
                else {
//                    List<CSInfo> csinfos = Util.extractCSInfo(file);
//                    for (int k = 0; k < csinfos.size(); k++) {
//                        CSInfo csinfo = csinfos.get(k);
//                        String fn = csinfo.getExprs().get(0).getFilename();
//                        if (fn.contains(fname)/*&& isinTab.equals("true")*/) {
//                            System.out.println("If case taken");
//                            //Messages.showMessageDialog("If case taken", "Info Box", Messages.getInformationIcon());
//
//                            System.out.println("Right before changeDocument function");
//                            //Messages.showMessageDialog("Right before changeDocument function", "Info Box", Messages.getInformationIcon());
//                            changeDocument(csinfo, document, project, editor);
//                            //changed = 1;
//
//                        }
//                        System.out.println(fname);
//                    }
                }

            }
        };


        WriteCommandAction.runWriteCommandAction(project,runnable);
    }
}
