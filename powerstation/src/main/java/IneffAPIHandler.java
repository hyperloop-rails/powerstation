import com.intellij.openapi.actionSystem.*;
import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.openapi.editor.Document;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.colors.EditorColors;
import com.intellij.openapi.editor.markup.HighlighterLayer;
import com.intellij.openapi.editor.markup.HighlighterTargetArea;
import com.intellij.openapi.editor.markup.TextAttributes;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.TextRange;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class IneffAPIHandler extends AnAction {

    public void actionPerformed(AnActionEvent e) {
        //final Editor editor = e.getData(CommonDataKeys.EDITOR);
        //final Editor editor = DataKeys.EDITOR_EVEN_IF_INACTIVE.getData(e.getDataContext());
//        Editor editor1 = e.getData(PlatformDataKeys.EDITOR_EVEN_IF_INACTIVE);
//        while (editor1 == null){
//            editor1 = e.getData(PlatformDataKeys.EDITOR_EVEN_IF_INACTIVE);
//        }
        final  Editor editor = FileEditorManager.getInstance(e.getProject()).getSelectedTextEditor();
        if (editor == null)
            return;
        //final Editor editor = editor1;
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
                Util.removeHighlighters(project);
                String str = document.getText(new TextRange(start, end));
                /*if (str.equals("any?")){
                    document.replaceString(start, end, "exists?");
                }*/
                //str = str.replaceAll("\\.any\\?", ".exists?");

                /*int index1 = str.indexOf(".any?");
                if (index1 != -1){
                    int endind = index1 + ".any?".length();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                        editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(index1, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);

                    int num = document.getLineNumber(index1);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".any?", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".any? => .exists?", aList);


                }*/

                Pattern anyP = Pattern.compile("\\.any\\?");
                Matcher anyM = anyP.matcher(str);
                //Find all occurrences and highlight them
                while (anyM.find()){
                    int startind = anyM.start();
                    int endind = anyM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);

                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".any?", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".any?", aList);


                }

                //str = str.replaceAll("\\.where\\.first", ".find_by");
                Pattern wfP = Pattern.compile("\\.where\\(.*\\)\\.first");
                Matcher wfM = wfP.matcher(str);
                while (wfM.find()){
                    int startind = wfM.start();
                    int endind = wfM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".where.first", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".where.first", aList);
                }

                /*if (str.equals("each.update")){
                    document.replaceString(start, end, "update_all");
                }*/

                //str = str.replaceAll("\\.each\\.update", ".update_all");

                Pattern euP = Pattern.compile("\\.each\\.update");
                Matcher euM = euP.matcher(str);
                while (euM.find()){
                    int startind = euM.start();
                    int endind = euM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".each.update", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".each.update", aList);
                }

                /*if (str.equals(".count")){
                    document.replaceString(start, end, ".size");
                }*/

                //str = str.replaceAll("\\.count", ".size");
                Pattern countP = Pattern.compile("\\.count");
                Matcher countM = countP.matcher(str);
                while (countM.find()){
                    int startind = countM.start();
                    int endind = countM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".count", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".count", aList);
                }

                /*if (str.equals(".map")){
                    document.replaceString(start, end, ".pluck");
                }*/
                //str = str.replaceAll("\\.map", ".pluck");

                Pattern mapP = Pattern.compile("\\.map");
                Matcher mapM = mapP.matcher(str);
                while (mapM.find()){
                    int startind = mapM.start();
                    int endind = mapM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".map", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".map", aList);
                }

                /*if (str.equals("pluck.sum")){
                    document.replaceString(start, end, ".sum");
                }*/

                //str = str.replaceAll("\\.pluck\\(.*\\)\\.sum", ".sum");

                Pattern plucksumP = Pattern.compile("\\.pluck\\(.*\\)\\.sum");
                Matcher plucksumM = plucksumP.matcher(str);
                while (plucksumM.find()){
                    int startind = plucksumM.start();
                    int endind = plucksumM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".pluck.sum", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put(".pluck.sum", aList);
                }


                /*if (str.equals("pluck + pluck")){
                    document.replaceString(start, end, "SQL-UNION");
                }*/
                //str = str.replaceAll("pluck\\(.*\\) \\+ pluck\\(.*\\)", "SQL-UNION");

                Pattern unionP = Pattern.compile("pluck\\(.*\\) \\+ pluck\\(.*\\)");
                Matcher unionM = plucksumP.matcher(str);
                while (unionM.find()){
                    int startind = unionM.start();
                    int endind = unionM.end();
                    TextAttributes ta2 = new TextAttributes(editor.getColorsScheme().getColor(EditorColors.SELECTION_FOREGROUND_COLOR),
                            editor.getColorsScheme().getColor(EditorColors.SELECTION_BACKGROUND_COLOR), null, null, 0);
                    editor.getMarkupModel().addRangeHighlighter(startind, endind, HighlighterLayer.ADDITIONAL_SYNTAX + 2, ta2, HighlighterTargetArea.EXACT_RANGE);
                    int num = document.getLineNumber(startind);
                    ArrayList<Integer> aList = tbdisplayed.getOrDefault(".pluck + pluck", new ArrayList<>());
                    aList.add(num);
                    tbdisplayed.put("pluck + pluck", aList);
                }

                document.setText(str);

            }

        };
        //Making the replacement
        WriteCommandAction.runWriteCommandAction(project, runnable);
        ErrorMenu em = new ErrorMenu(tbdisplayed, e);
        em.setVisible(true);
    }

}
