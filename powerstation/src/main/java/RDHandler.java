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
import com.intellij.openapi.editor.markup.RangeHighlighter;
import com.intellij.openapi.editor.markup.TextAttributes;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.util.TextRange;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiFile;
import org.apache.commons.lang.StringUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.List;

public class RDHandler extends AnAction {
    RDInfo rd;
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

    public void changeDocument(RDInfo rdinfo, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        System.out.println("In changeDocument function");
        Statement stm = rdinfo.getStm();
        String filename =  stm.getFilename();
        rdinfo.getActual_used_size();
        rdinfo.getTotalFieldSize();
        String table = rdinfo.getTable();
        String ufield = rdinfo.getUnused_field();
        String usfield = rdinfo.getUsed_field();
        int loc = stm.getStatement();
        int indlend = d.getLineEndOffset(loc - 1);
        int indlstart = d.getLineStartOffset(loc - 1);
        //TODO maybe in different files
        try {
            TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                    editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
            RangeHighlighter rangeHighlighter  = editor.getMarkupModel().addRangeHighlighter(indlstart, indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
            String error_msg = "Unused field: " + ufield + " in " + table;
            String expr = editor.getDocument().getText(new TextRange(indlstart, indlend)).trim();
            if(usfield.equals("empty")){
                error_msg += "\nFix: remove " + expr;
            }
            else{
                String[] usfields = usfield.split(",");
                String ufs = StringUtils.join(usfields, ": ,");
                ufs = "(:" + ufs + ")";
                error_msg += "\nFix: append " + ufs;
            }

            Util.addTooltips( editor,  error_msg,  loc);


        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
            System.exit(1);
        }


    }
    public void fixDocument(RDInfo rdinfo, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        System.out.println("In changeDocument function");
        Statement stm = rdinfo.getStm();
        String filename =  stm.getFilename();
        rdinfo.getActual_used_size();
        rdinfo.getTotalFieldSize();
        String usfield = rdinfo.getUsed_field();
        int loc = stm.getStatement();
        int indlend = d.getLineEndOffset(loc - 1);
        int indlstart = d.getLineStartOffset(loc - 1);
        //TODO maybe in different files
        try {
            if(usfield.equals("empty")){
                d.deleteString(indlstart, indlend);
            }
            else{
                String[] usfields = usfield.split(",");
                String ufs = StringUtils.join(usfields, ": ,");
                ufs = ".select(:" + ufs + ")";
                d.insertString(indlend, ufs);
            }

        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
            System.exit(1);
        }


    }

    public void actionPerformed(final AnActionEvent anActionEvent) {
        //Get all the required data from data keys
        //final Editor editor = anActionEvent.getData(CommonDataKeys.EDITOR);
        final  Editor editor = FileEditorManager.getInstance(anActionEvent.getProject()).getSelectedTextEditor();
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
        System.out.println("ACTUAL PATH: " + actualpath);
        //Access document, caret, and selection
        final com.intellij.openapi.editor.Document document = editor.getDocument();
        VirtualFile vf = FileDocumentManager.getInstance().getFile(document);
        if (vf == null){
            Messages.showMessageDialog("Invalid document: either does not exist, or is too large.", "Failure", Messages.getErrorIcon());
        }

        IdeaPluginDescriptor plugin = PluginManager.getPlugin(PluginId.getId("com.intellij.powerstation"));

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                editor.getMarkupModel().removeAllHighlighters();
                String results_path = Util.getRP(project);
                File file = new File(results_path + "redundant_usage.xml");
                List<RDInfo> rdinfos = Util.extractRDInfos(file);
                com.intellij.openapi.editor.Document doc = FileEditorManager.getInstance(anActionEvent.getProject()).getSelectedTextEditor().getDocument();
                VirtualFile vf = FileDocumentManager.getInstance().getFile(doc);
                String vfname = vf.getName();
                if(rd != null){
                    if(fix) {
                        fixDocument(rd, document, project, editor);
                    }
                    else{
                        changeDocument(rd, document, project, editor);
                    }
                }else {
//                    for (int k = 0; k < rdinfos.size(); k++) {
//                        RDInfo rdinfo = rdinfos.get(k);
//                        String fn = rdinfo.getStm().getFilename();
//                        if (fn.contains(vfname)/*&& isinTab.equals("true")*/) {
//                            System.out.println("If case taken");
//                            //Messages.showMessageDialog("If case taken", "Info Box", Messages.getInformationIcon());
//
//                            System.out.println("Right before changeDocument function");
//                            //Messages.showMessageDialog("Right before changeDocument function", "Info Box", Messages.getInformationIcon());
//                            changeDocument(rdinfo, document, project, editor);
//                            //changed = 1;
//
//                        }
//                        System.out.println(vfname);
//                    }
                }

            }
        };


        WriteCommandAction.runWriteCommandAction(project,runnable);
    }

}
