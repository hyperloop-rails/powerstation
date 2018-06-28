import com.intellij.openapi.actionSystem.AnActionEvent;

import javax.swing.*;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.*;

public class LoopErrorMenu extends JFrame {
    private HashSet<Integer> errors;
    private AnActionEvent a;

    public LoopErrorMenu(HashSet<Integer> errors, AnActionEvent a) {
        super("Loop Warnings");
        this.a = a;
        setSize(500, 700);
        this.getContentPane().setLayout(new BorderLayout());

        JPanel treePane = new JPanel();
        treePane.setSize(500, 500);
        treePane.setLayout(new BorderLayout());

        //Construct the tree out of the given data
        int ecount = errors.size();

        DefaultMutableTreeNode root = new DefaultMutableTreeNode(Integer.toString(ecount) + " Warnings");
        ArrayList<DefaultMutableTreeNode> enames = new ArrayList<>();

        for (Integer e : errors) {
            DefaultMutableTreeNode name = new DefaultMutableTreeNode(e);
            enames.add(name);
            root.add(name);
        }

        JCheckBoxTree cbt = new JCheckBoxTree(root);
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
            public void actionPerformed(ActionEvent e) {
                //fix only those issues that the developer checked
            }
        });

        JButton fixallbutton = new JButton("Fix All");
        fixallbutton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                //unsure how a fix is going to happen

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
    }
}
