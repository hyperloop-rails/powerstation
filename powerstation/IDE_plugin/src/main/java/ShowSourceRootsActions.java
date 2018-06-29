import com.intellij.openapi.actionSystem.*;
import com.intellij.openapi.project.Project;
import org.jetbrains.annotations.NotNull;
import com.intellij.openapi.application.ApplicationManager;
public class ShowSourceRootsActions extends AnAction {
    @Override
    public void actionPerformed(@NotNull final AnActionEvent event) {

            Util.runAnalysis(event, null);
            Project project = event.getProject();
            Util.showToolWindows(event, project);



    }

    @Override
    public void update(@NotNull final AnActionEvent event) {
        boolean visibility = event.getProject() != null;
        event.getPresentation().setEnabled(visibility);
        event.getPresentation().setVisible(visibility);
    }
}