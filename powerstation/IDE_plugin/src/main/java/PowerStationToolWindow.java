import com.intellij.openapi.project.Project;
import com.intellij.openapi.wm.ToolWindow;
import com.intellij.openapi.wm.ToolWindowFactory;
import com.intellij.ui.content.ContentFactory;
import org.jetbrains.annotations.NotNull;
import java.awt.event.*;
import javax.swing.*;
import com.intellij.ui.content.*;

public class PowerStationToolWindow implements ToolWindowFactory {
    private JLabel title = new JLabel("Refactor");
    private JButton hide_window_btn = new JButton("hide");
    private JButton refresh_window_btn = new JButton("refresh");
    private ToolWindow refactor_window;
    public PowerStationToolWindow(){
        hide_window_btn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                refactor_window.hide(null);
            }
        });
        refresh_window_btn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                PowerStationToolWindow.this.start();
            }
        });
    }

    @Override
    public void createToolWindowContent(@NotNull Project project, @NotNull ToolWindow toolWindow) {
        this.refactor_window = toolWindow;
//        ContentFactory contentFactory = ContentFactory.SERVICE.getInstance();
//        Content content = contentFactory.createContent(refactor_window_content, "", false);
//        refactor_window.getContentManager().addContent(content);
    }
    public void addContent(JPanel added){
        ContentFactory contentFactory = ContentFactory.SERVICE.getInstance();
        Content content = contentFactory.createContent(added, "", false);
        refactor_window.getContentManager().addContent(content);
    }
    public void start(){
    }
}