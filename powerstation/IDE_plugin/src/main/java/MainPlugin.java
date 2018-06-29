import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;
public class MainPlugin extends AnAction {

    public void actionPerformed(AnActionEvent e) {
        Project project = e.getProject();
        actionPerformed(e, project, SettingsContext.NONE);

    }

    public void actionPerformed(AnActionEvent e, Project project, SettingsContext settingsContext){

        Editor editor = FileEditorManager.getInstance(project).getSelectedTextEditor();
        String text = editor.getDocument().getText();
        VirtualFile vf = FileDocumentManager.getInstance().getFile(editor.getDocument());
        if(!vf.getPath().contains("/controllers")){
            return;
        }
        String[] lines = text.split("\n");
        String controller = null;
        List<String> as = new ArrayList<>();
        for(String line: lines){
            String l = line.trim();
            if (l.startsWith("class ")){
                int s = l.indexOf("class ");
                int end = l.indexOf((" <"));
                controller = l.substring(s + 6, end);
            }
            if (l.startsWith("def ")){
                int s = l.indexOf("def ");
                String a = l.substring(s + 4, l.length());
                as.add(a);
            }
        }
        JFrame actions = new JFrame();
        JPanel buttonPane = new JPanel();
        actions.add(buttonPane);
        actions.setVisible(true);
        buttonPane.setLayout(new GridLayout(0,1));
        buttonPane.setSize(new Dimension(50,100));
        buttonPane.setVisible(true);
        actions.setSize(new Dimension(50,100));
        if (controller == null || as.size() == 0){
            buttonPane.add(new JLabel("There is no action"));
        }
        else{
            String c = controller;
            for(String btnString: as) {
                JButton btn = new JButton(btnString);
                buttonPane.add(btn);
                btn.setSize(new Dimension(45, 20));
                btn.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent event) {
                        String c_a = c + "," + btn.getText();
                        Util.runAnalysis(e, c_a);
                        Util.showToolWindows(e, project);
                    }
                });
            }
        }

    }
}
