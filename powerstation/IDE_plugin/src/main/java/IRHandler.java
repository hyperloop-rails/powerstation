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
import java.util.List;
import java.util.UUID;
public class IRHandler extends AnAction {
    IRInfo ir;
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

    public void changeDocument(IRInfo irf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        int state = irf.getStatement();
        System.out.println("In changeDocument function");
        if (state <= 0){
            System.out.println("ERROR: This can't be a dead-store query");
            return;
        }
        int indlend = d.getLineEndOffset(state - 1);
        int indlstart = d.getLineStartOffset(state - 1);
        String expr = editor.getDocument().getText(new TextRange(indlstart, indlend)).trim();
        String error_msg = expr + " is inefficient render\nFix: hoist " + expr;
        Util.addTooltips( editor,  error_msg,  state);

        System.out.println("Got start and end offsets for loc1 and loc2");
        try {
            editor.getMarkupModel().removeAllHighlighters();
            TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                    editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
            editor.getMarkupModel().addRangeHighlighter(indlstart, indlend, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);

        }catch (ExceptionInInitializerError ex){
            System.out.println("Text Attributes is null");
            Messages.showMessageDialog("Text Attributes is null", "Info Box", Messages.getInformationIcon());
            System.exit(1);
        }


    }
    public void fixDocument(IRInfo irf, com.intellij.openapi.editor.Document d, Project project, Editor editor){
        int state = irf.getStatement();
        System.out.println("In changeDocument function");
        if (state <= 0){
            System.out.println("ERROR: This can't be a dead-store query");
            return;
        }
        int indlend = d.getLineEndOffset(state - 1);
        int indlstart = d.getLineStartOffset(state - 1);
        int insertoffset = d.getLineStartOffset(ir.getStart() - 1);

        String expr = editor.getDocument().getText(new TextRange(indlstart, indlend)).trim();
        System.out.println("Got start and end offsets for loc1 and loc2");
        String[] args = irf.getArgs().split(",");
        String var = "\t\tv" + UUID.randomUUID().toString().replaceAll("-","").substring(0,3);
        String gsub = var;
        for(int i = 0; i < args.length; i ++){
            String arg = args[i];
            expr = expr.replace(" " + arg, " 'parameter" + i + "'");
            gsub = gsub + ".gsub('parameter" + i + "', " + arg + ")";
        }
        String newStament = var + " = " + expr;
        try {
            d.replaceString(indlstart, indlend, gsub);
            d.insertString(insertoffset, newStament + "\n");
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
                //String thistext = document.getText(new TextRange(start, end));
                //File file = new File("C://Users/subma/Documents/xmlsample.xml");
                Util.removeHighlighters(project);

                String results_path = Util.getRP(project);
                File file = new File(results_path + "inefficient_render.xml");
                //file = new File("/Users/jwy/Research/Code/pw/src/main/resources/static-analyzer/applications/pw-blog/results/inefficient_render.xml");
                if(ir != null){
                    if(fix){
                        fixDocument(ir, document, project, editor);
                    }
                    else {
                        changeDocument(ir, document, project, editor);
                    }
                }
                else {
//                    List<IRInfo> irfs = Util.extractIRInfo(file);
//                    for (int k = 0; k < irfs.size(); k++) {
//                        IRInfo irf = irfs.get(k);
//                        if (irf.getFilename().contains(fname)) {
//                            System.out.println("If case taken");
//                            System.out.println("Right before changeDocument function");
//                            //Messages.showMessageDialog("Right before changeDocument function", "Info Box", Messages.getInformationIcon());
//                            changeDocument(irf, document, project, editor);
//                            //changed = 1;
//
//                        }
//                        System.out.println(fname);
//                    }
                }
            }
        };



        WriteCommandAction.runWriteCommandAction(project,runnable);
        //CommandProcessor.getInstance().executeCommand(project, runnable, "Multihighlight", null);
        //selectionModel.removeSelection();
    }
}