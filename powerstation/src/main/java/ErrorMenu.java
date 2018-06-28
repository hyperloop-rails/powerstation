import com.intellij.openapi.actionSystem.AnActionEvent;

import javax.swing.*;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ErrorMenu extends JFrame {

    private HashMap<String, ArrayList<Integer>> errors;
    private AnActionEvent a;

    public ErrorMenu(HashMap<String, ArrayList<Integer>> errors, AnActionEvent a) {
        super("Inefficient API Warnings");
        this.a = a;
        setSize(500, 700);
        this.getContentPane().setLayout(new BorderLayout());

        JPanel treePane = new JPanel();
        treePane.setSize(500, 500);
        treePane.setLayout(new BorderLayout());

        //Construct the tree out of the given data
        int ecount = 0;
        for (Map.Entry<String, ArrayList<Integer>> entry : errors.entrySet()){
            ecount += entry.getValue().size();
        }
        DefaultMutableTreeNode root = new DefaultMutableTreeNode(Integer.toString(ecount) + " Warnings");
        ArrayList<DefaultMutableTreeNode> enames = new ArrayList<>();

        for (Map.Entry<String, ArrayList<Integer>> entry : errors.entrySet()){
            DefaultMutableTreeNode name = new DefaultMutableTreeNode(entry.getKey());
            for (int i = 0; i < entry.getValue().size(); i++){
                DefaultMutableTreeNode linenum = new DefaultMutableTreeNode("Line " + Integer.toString(entry.getValue().get(i) + 1));
                name.add(linenum);
            }
            enames.add(name);
            root.add(name);
        }

        JCheckBoxTree cbt = new JCheckBoxTree(root);
        //this.getContentPane().add(cbt);
        treePane.add(cbt);

        cbt.addCheckChangeEventListener(new JCheckBoxTree.CheckChangeEventListener() {
            public void checkStateChanged(JCheckBoxTree.CheckChangeEvent event) {
                System.out.println("event");
                TreePath[] paths = cbt.getCheckedPaths();
                for (TreePath tp : paths) {
                    for (Object pathPart : tp.getPath()) {
                        System.out.print(pathPart + ",");
                    }
                    System.out.println();
                }
            }
        });

        JButton okbutton = new JButton("OK");
        okbutton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                //fix only those issues that the developer checked
            }
        });

        JButton fixallbutton = new JButton("Fix All");
        fixallbutton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                //do what the original code did: fix everything in the current file
                FixAllAPI fx = new FixAllAPI();
                fx.actionPerformed(a);

            }
        });

        JPanel buttonPane = new JPanel();
        buttonPane.setLayout(new BoxLayout(buttonPane, BoxLayout.LINE_AXIS));

        buttonPane.add(Box.createHorizontalGlue());
        buttonPane.add(fixallbutton);
        buttonPane.add(Box.createRigidArea(new Dimension(10, 0)));
        buttonPane.add(okbutton);

        //Combine buttonPane and treePane
        this.getContentPane().add(treePane, BorderLayout.CENTER);
        this.getContentPane().add(buttonPane, BorderLayout.PAGE_END);

        //this.setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
}
