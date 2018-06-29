import com.intellij.openapi.actionSystem.*;
import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.openapi.editor.Document;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.colors.EditorColors;
import com.intellij.openapi.editor.markup.HighlighterLayer;
import com.intellij.openapi.editor.markup.HighlighterTargetArea;
import com.intellij.openapi.editor.markup.TextAttributes;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.TextRange;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

public class FixAllAPI extends AnAction {

    public void actionPerformed(AnActionEvent e) {
        //final Editor editor = e.getData(CommonDataKeys.EDITOR);
        //final Editor editor = DataKeys.EDITOR_EVEN_IF_INACTIVE.getData(e.getDataContext());
        Editor editor1 = e.getData(PlatformDataKeys.EDITOR_EVEN_IF_INACTIVE);
        while (editor1 == null){
            editor1 = e.getData(PlatformDataKeys.EDITOR_EVEN_IF_INACTIVE);
        }
        final Editor editor = editor1;
        final Project project = e.getData(PlatformDataKeys.PROJECT);
        //Access document, caret, and selection
        final Document document = editor.getDocument();
        int start = 0;
        int end = document.getTextLength();
        HashMap<String, ArrayList<Integer>> tbdisplayed = new HashMap<>();
        //insert plugin function from inefficient API solver
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                String str = document.getText(new TextRange(start, end));
                /*if (str.equals("any?")){
                    document.replaceString(start, end, "exists?");
                }*/
                str = str.replaceAll("\\.any\\?", ".exists?");
                //str = str.replaceAll("\\.where\\.first", ".find_by");
                str = str.replaceAll("\\.where\\((.*)\\)\\.first", ".find_by\\(" + "$1" + "\\)");
                /*if (str.equals("each.update")){
                    document.replaceString(start, end, "update_all");
                }*/
                str = str.replaceAll("\\.each\\.update", ".update_all");
                /*if (str.equals(".count")){
                    document.replaceString(start, end, ".size");
                }*/
                str = str.replaceAll("\\.count", ".size");
                /*if (str.equals(".map")){
                    document.replaceString(start, end, ".pluck");
                }*/
                str = str.replaceAll("\\.map", ".pluck");
                /*if (str.equals("pluck.sum")){
                    document.replaceString(start, end, ".sum");
                }*/
                str = str.replaceAll("\\.pluck\\((.*)\\)\\.sum", ".sum\\($1\\)");
                /*if (str.equals("pluck + pluck")){
                    document.replaceString(start, end, "SQL-UNION");
                }*/
                str = str.replaceAll("pluck\\((.*)\\) \\+ pluck\\((.*)\\)", "SQL-UNION $1 $2");

                document.setText(str); //this seems to work...

            }

        };
        //Making the replacement
        WriteCommandAction.runWriteCommandAction(project, runnable);

    }

}
