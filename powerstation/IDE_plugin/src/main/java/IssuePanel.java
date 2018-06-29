import javax.swing.*;

import java.awt.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class IssuePanel {
    List<JButton> issueBtns;
    List<JButton> fixBtns;
    JPanel panel = new JPanel();

    public void createFixBtns(){
        fixBtns = new ArrayList<JButton>();
        for(int i = 0; i < issueBtns.size(); i ++){
            JButton fixBtn = new JButton("fix");
            fixBtns.add(fixBtn);
        }
    }
    public void addToPanel(){
        panel.setLayout(new GridLayout(issueBtns.size(),1));
        for(int i = 0; i < issueBtns.size(); i ++){
            JButton issueBtn = issueBtns.get(i);
            JButton fixBtn = fixBtns.get(i);
            JPanel btnPanel = new JPanel();
            issueBtn.setPreferredSize(new Dimension(300, 20));
            fixBtn.setPreferredSize(new Dimension(40, 20));
            btnPanel.add(issueBtn);
            btnPanel.add(fixBtn);
            panel.add(btnPanel);
            btnPanel.setVisible(true);
        }
        panel.setVisible(true);
    }
    public List<JButton> getIssueBtns() {
        return issueBtns;
    }

    public void setIssueBtns(List<JButton> issueBtns) {
        this.issueBtns = issueBtns;
    }

    public List<JButton> getFixBtns() {
        return fixBtns;
    }

    public void setFixBtns(List<JButton> fixBtns) {
        this.fixBtns = fixBtns;
    }

    public JPanel getPanel() {
        return panel;
    }

    public void setPanel(JPanel panel) {
        this.panel = panel;
    }
}
