import com.intellij.ide.plugins.IdeaPluginDescriptor;
import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.openapi.editor.Document;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.event.EditorMouseMotionListener;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.util.TextRange;
import com.intellij.openapi.vfs.LocalFileSystem;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.openapi.wm.ToolWindow;
import com.intellij.openapi.wm.ToolWindowManager;
import com.intellij.ui.components.JBTabbedPane;
import com.intellij.ui.content.Content;
import com.intellij.ui.content.ContentFactory;
import javafx.util.Pair;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.regex.Pattern;

public class MainMenu {
    AnActionEvent a;
    public JFrame frame = new JFrame("PowerStation");
    public JPanel rootComponent = new JPanel();
    public JButton redundantDataButton = new JButton("RD");
    public JPanel IRPanel = new JPanel();
    public JPanel CSPanel = new JPanel();
    public JPanel IAPanel = new JPanel();
    public JPanel LIPanel = new JPanel();
    public JPanel DSPanel = new JPanel();
    public JPanel RDPanel = new JPanel();
    public JPanel IRFilePanel = new JPanel();
    public JPanel IAFilePanel = new JPanel();
    public String basedir ;
    List<CSInfo> csinfos;
    List<IRInfo> irInfos;
    List<LoopInfo> loopInfos;
    List<DSInfo> dsInfos;
    List<RDInfo> rdinfos;

    public MainMenu(AnActionEvent a){
        this.a = a;
        basedir = this.a.getProject().getBasePath();
        if (basedir == null){
            System.out.println("ERROR: basedir is null");
            System.exit(-1);
        }else {
            System.out.println(basedir);
        }
        String results_path;
        results_path = Util.getRP(a.getProject());
        rootComponent.setLayout(new FlowLayout());
        File file;


        IRPanel.setLayout(new GridLayout(2,0));
        file = new File(results_path + "/inefficient_render.xml");
        irInfos = Util.extractIRInfo(file);
        IssuePanel IRIP = Util.constructIRPanel(irInfos);
        IRPanel.add(IRIP.panel);



        CSPanel.setLayout(new GridLayout(2,0));
        file = new File(results_path + "/common_subexpression.xml");
        csinfos = Util.extractCSInfo(file);
        IssuePanel CSIP = Util.constructCSPanel(csinfos);
        CSPanel.add(CSIP.panel);


        IAPanel.setLayout(new GridLayout(2,0));
        IAPanel.add(IAFilePanel);
        JButton cufBtn = new JButton("Current File");
        IRFilePanel.setLayout(new FlowLayout());
        cufBtn.setPreferredSize(new Dimension(200, 20));
        IAFilePanel.add(cufBtn);

        LIPanel.setLayout(new GridLayout(2,0));
        file = new File(results_path + "/loop_invariant.xml");
        loopInfos = Util.extractLIInfo(file);
        IssuePanel LIIP = Util.constructLIPanel(loopInfos);
        LIPanel.add(LIIP.panel);

        DSPanel.setLayout(new GridLayout(2,0));
        file = new File(results_path + "/dead_store.xml");
        dsInfos = Util.extractDSInfo(file);
        IssuePanel DSIP = Util.constructDSPanel(dsInfos);
        DSPanel.add(DSIP.panel);


        RDPanel.setLayout(new GridLayout(2,0));
        redundantDataButton.setToolTipText("Redundant Data Retrieval");
        file = new File(results_path + "/redundant_usage.xml");
        rdinfos = Util.extractRDInfos(file);
        IssuePanel RDIP = Util.constructRDPanel(rdinfos);
        RDPanel.add(RDIP.panel);


        //JTabbedPane tp = new JTabbedPane();
        JBTabbedPane tp = new JBTabbedPane();
        tp.add("LI", LIPanel);
        tp.setToolTipTextAt(0, "Loop Invariant");
        tp.add("IA", IAPanel);
        tp.setToolTipTextAt(1, "Inefficient API");
        tp.add("CS", CSPanel);
        tp.setToolTipTextAt(2, "Common Subexpressions");
        tp.add("IR", IRPanel);
        tp.setToolTipTextAt(3, "Inefficient Rendering");
        tp.add("DS", DSPanel);
        tp.setToolTipTextAt(4, "Dead Store queries");
        tp.add("RD", RDPanel);
        tp.setToolTipTextAt(5, "Redundant Data Retrieval");
        rootComponent.add(tp);

        tp.addChangeListener(new ChangeListener() { //add the Listener

            public void stateChanged(ChangeEvent e) {

                System.out.println(""+tp.getSelectedIndex());

                if(tp.getSelectedIndex()==0)
                {
                    LoopInvHandler lih = new LoopInvHandler();
                    lih.actionPerformed(a);


                }
                if(tp.getSelectedIndex()==1)
                {
                    IneffAPIHandler h = new IneffAPIHandler();
                    h.actionPerformed(a);
                }
                if(tp.getSelectedIndex()==2)
                {
                    CSHandler csh = new CSHandler();
                    csh.actionPerformed(a);
                }
                if(tp.getSelectedIndex()==3)
                {
                    IRHandler irh = new IRHandler();
                    irh.actionPerformed(a);

                }
                if(tp.getSelectedIndex()==4)
                {
                    DSQHandler dqh = new DSQHandler();
                    dqh.actionPerformed(a);
                }
                if(tp.getSelectedIndex()==5)
                {
                    RDHandler rdh = new RDHandler();
                    rdh.actionPerformed(a);
                }
            }
        });
        for(int i = 0 ;i < irInfos.size(); i ++){
            JButton label = IRIP.getIssueBtns().get(i);
            JButton fix = IRIP.fixBtns.get(i);
            IRInfo ir = irInfos.get(i);
            String view_file_path = basedir + "/app/" + ir.getFilename();
            System.out.println(view_file_path);
            VirtualFile view_file = LocalFileSystem.getInstance().findFileByPath(view_file_path);

            label.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    Util.removeHighlighters(a.getProject());
                     FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    IRHandler irh = new IRHandler();
                    irh.ir = ir;
                    irh.actionPerformed(a);
                }
            });
            fix.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    IRHandler irh = new IRHandler();
                    irh.ir = ir;
                    irh.fix = true;
                    irh.actionPerformed(a);
                    String fn = ir.getFilename();
                    int start = ir.getStart();
                    int loc = ir.getStatement();
                    Util.updateLI(loopInfos, fn, start, loc);
                    Util.updateCS(csinfos, fn, start, loc);
                    Util.updateDS(dsInfos, fn, start, loc);
                    Util.updateIR(irInfos, fn, start, loc);
                    Util.updateRD(rdinfos, fn, start, loc);
                    //fix.setEnabled(false);
                    fix.setText("undo");
                }
            });

        }


        for(int i = 0 ;i < csinfos.size(); i ++){
            JButton label = CSIP.getIssueBtns().get(i);
            JButton fix = CSIP.fixBtns.get(i);
            CSInfo cs = csinfos.get(i);
            String view_file_path = basedir + "/app/" + cs.getExprs().get(0).getFilename();
            System.out.println(view_file_path);
            VirtualFile view_file = LocalFileSystem.getInstance().findFileByPath(view_file_path);

            label.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                     FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    CSHandler csh = new CSHandler();
                    csh.cs = cs;
                    csh.actionPerformed(a);
                }
            });
            fix.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    CSHandler csh = new CSHandler();
                    csh.cs = cs;
                    csh.fix = true;
                    csh.actionPerformed(a);
                    //fix.setEnabled(false);
                    fix.setText("undo");
                }
            });

        }


        for(int i = 0 ;i < rdinfos.size(); i ++){
            JButton label = RDIP.getIssueBtns().get(i);
            JButton fix = RDIP.fixBtns.get(i);
            RDInfo rd = rdinfos.get(i);
            String view_file_path = basedir + "/app/" + rd.getStm().getFilename();
            System.out.println(view_file_path);
            VirtualFile view_file = LocalFileSystem.getInstance().findFileByPath(view_file_path);
            label.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    RDHandler rdh = new RDHandler();
                    rdh.rd = rd;
                    rdh.actionPerformed(a);
                }
            });
            fix.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    RDHandler rdh = new RDHandler();
                    rdh.rd = rd;
                    rdh.fix = true;
                    rdh.actionPerformed(a);
                    //fix.setEnabled(false);
                    fix.setText("undo");
                }
            });

        }


        cufBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                IneffAPIHandler h = new IneffAPIHandler();
                h.actionPerformed(a);

            }


        });

        attachLI(LIIP, loopInfos);

        for(int i = 0 ;i < dsInfos.size(); i ++){
            JButton label = DSIP.getIssueBtns().get(i);
            JButton fix = DSIP.getFixBtns().get(i);
            DSInfo ds = dsInfos.get(i);
            String view_file_path = basedir + "/app/" + ds.getFilename1();
            System.out.println(view_file_path);
            VirtualFile view_file = LocalFileSystem.getInstance().findFileByPath(view_file_path);
            label.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    DSQHandler dqh = new DSQHandler();
                    dqh.ds = ds;
                    dqh.actionPerformed(a);
                }
            });
            fix.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {

                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    DSQHandler dqh = new DSQHandler();
                    dqh.ds = ds;
                    dqh.fix = true;
                    dqh.actionPerformed(a);
                    //fix.setEnabled(false);
                    fix.setText("undo");
                }
            });

        }


    }

    void attachLI(IssuePanel LIIP, List<LoopInfo> loopInfos){
        for(int i = 0 ;i < loopInfos.size(); i ++){
            JButton label;// = LILabels.get(i);
            label = LIIP.issueBtns.get(i);
            JButton fix = LIIP.fixBtns.get(i);
            LoopInfo li = loopInfos.get(i);
            String view_file_path = basedir + "/app/" + li.getFilename();
            System.out.println(view_file_path);
            VirtualFile view_file = LocalFileSystem.getInstance().findFileByPath(view_file_path);

            label.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    LoopInvHandler lih = new LoopInvHandler();
                    lih.li = li;
                    System.out.println("Statement: " + li);
                    lih.actionPerformed(a);
                    System.out.println("performed " + view_file_path);
                }
            });
            fix.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    Util.removeHighlighters(a.getProject());
                    FileEditorManager.getInstance(a.getProject()).openFile(view_file, true);
                    LoopInvHandler lih = new LoopInvHandler();
                    lih.li = li;
                    lih.fix = true;
                    lih.actionPerformed(a);
                    //fix.setEnabled(false);
                    fix.setText("undo");
                    int start = li.getStart();
                    int loc = li.getStatement();
                    String fn = li.getFilename();
                    Util.updateCS(csinfos, fn, start, loc);
                    Util.updateDS(dsInfos, fn, start, loc);
                    Util.updateIR(irInfos, fn, start, loc);
                    Util.updateRD(rdinfos, fn, start, loc);
                    Util.updateLI(loopInfos, fn, start, loc);
                }
            });
        }
    }
}
