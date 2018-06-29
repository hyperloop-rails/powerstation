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
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.util.TextRange;
import com.intellij.openapi.vfs.VirtualFile;
import java.io.File;

public class DSQHandler extends AnAction {
    DSInfo ds;
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

    public void changeDocument(DSInfo dsf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        int loc1 = dsf.getLoc1();
        int loc2 = dsf.getLoc2();
        System.out.println("In changeDocument function");
        if (loc1 <= 0 || loc2 <= 0){
            System.out.println("ERROR: This can't be a dead-store query");
            return;
        }
        int l1indlend = d.getLineEndOffset(loc1 - 1);
        int l1indlstart = d.getLineStartOffset(loc1 - 1);
        int l2indlend = d.getLineEndOffset(loc2 - 1);
        int l2indlstart = d.getLineStartOffset(loc2 - 1);
        String expr = editor.getDocument().getText(new TextRange(l1indlstart, l1indlend)).trim();
        String error_msg = expr + " is a dead story query\nFix: remove " + expr;
        Util.addTooltips( editor,  error_msg,  loc1);
        System.out.println("Got start and end offsets for loc1 and loc2");
        try {

            editor.getMarkupModel().removeAllHighlighters();
            TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                    editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
            editor.getMarkupModel().addRangeHighlighter(l1indlstart, l1indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
            editor.getMarkupModel().addRangeHighlighter(l2indlstart, l2indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
            System.exit(1);
        }


    }
    public void fixDocument(DSInfo dsf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        int loc1 = dsf.getLoc1();
        int loc2 = dsf.getLoc2();
        System.out.println("In changeDocument function");
        if (loc1 <= 0 || loc2 <= 0){
            System.out.println("ERROR: This can't be a dead-store query");
            return;
        }
        int l1indlend = d.getLineEndOffset(loc1 - 1);
        int l1indlstart = d.getLineStartOffset(loc1 - 1);
        try {
            d.deleteString(l1indlstart, l1indlend);
        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
            System.exit(1);
        }


    }

    public void actionPerformed(final AnActionEvent anActionEvent) {
        //Get all the required data from data keys
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
        //Access document, caret, and selection
        final com.intellij.openapi.editor.Document document = editor.getDocument();
        VirtualFile vf = FileDocumentManager.getInstance().getFile(document);
        if (vf == null){
            Messages.showMessageDialog("Invalid document: either does not exist, or is too large.", "Failure", Messages.getErrorIcon());
        }

        String fname = vf.getName();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Util.removeHighlighters(project);
                String results_path  = Util.getRP(project);
                File file = new File(results_path + "dead_store.xml");
                if(ds != null){
                    if(fix){
                        fixDocument(ds, document, project, editor);
                    }
                    else {
                        changeDocument(ds, document, project, editor);
                    }
                }
                else {
//                    List<DSInfo> dsInfos = Util.extractDSInfo(file);
//                    for (int i = 0; i < dsInfos.size(); i++) {
//                        DSInfo dsf = dsInfos.get(i);
//                        if ((dsf.getFilename1().contains(fname) || dsf.getFilename2().contains(fname)) /*&& isinTab.equals("true")*/) {
//                            System.out.println("If case taken");
//                            System.out.println("Right before changeDocument function");
//                            changeDocument(dsf, document, project, editor);
//
//                        }
//                    }
                }


            }
        };


        WriteCommandAction.runWriteCommandAction(project,runnable);
        //CommandProcessor.getInstance().executeCommand(project, runnable, "Multihighlight", null);
        //selectionModel.removeSelection();
    }
}
