import com.intellij.ide.plugins.IdeaPluginDescriptor;
import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.editor.event.EditorMouseEvent;
import com.intellij.openapi.editor.event.EditorMouseMotionListener;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.roots.ProjectRootManager;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.ui.awt.RelativePoint;
import javafx.util.Pair;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.intellij.openapi.wm.ToolWindow;
import com.intellij.openapi.wm.ToolWindowManager;
import com.intellij.ui.content.Content;
import com.intellij.ui.content.ContentFactory;

import javax.swing.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Util {

    public static List<Pair<Editor, EditorMouseMotionListener>> editorListeners = new ArrayList<>();

    public static Pair<Editor, EditorMouseMotionListener> addTooltips(Editor editor, String error_msg, int loc){
        int height = editor.getLineHeight() * loc;
        Point p = new Point(200, height);
        com.intellij.openapi.editor.Document d = editor.getDocument();
        double x1 = 0; //start.getX();
        double x2 = 300;// end.getX();
        double y1 = height - editor.getLineHeight();
        //double y1 = start.getY();
        double y2 = height;
        String[] ers = error_msg.split("\n");
        String em = "<html>";
        for(int i = 0; i < ers.length; i ++){
            em = em + ers[i] + "<br/>";
        }
        em += "</html>";
        //double y2 = y1 + editor.getLineHeight();
        RelativePoint rp = new RelativePoint(editor.getContentComponent(), p);
        JLabel error_label = new JLabel(em);
        error_label.setFont(new Font("Serif", Font.BOLD, 18));
        JWindow jf = new JWindow();


        jf.setLayout(new BorderLayout());
        jf.add(error_label, BorderLayout.CENTER);
        jf.setLocationRelativeTo(editor.getContentComponent());
        jf.setLocation(rp.getPoint());
        jf.setSize(error_label.getPreferredSize());
        EditorMouseMotionListener emml = new EditorMouseMotionListener() {
            @Override
            public void mouseMoved(EditorMouseEvent e) {
                int x = e.getMouseEvent().getX();
                int y = e.getMouseEvent().getY();
                if(x > x1 && x < x2 && y > y1 && y < y2){
                    Point toolP = new Point(x + 100, y );
                    RelativePoint toolRP = new RelativePoint(editor.getContentComponent(), toolP);
                    jf.setLocationRelativeTo(editor.getContentComponent());
                    jf.setLocation(toolRP.getPoint());
                    jf.setVisible(true);
                }
                else{
                    jf.setVisible(false);
                }
            }

            @Override
            public void mouseDragged(EditorMouseEvent e) {

            }
        };
        editor.addEditorMouseMotionListener(emml);
        Pair<Editor, EditorMouseMotionListener> pair =  new Pair<>(editor, emml);
        if(!editorListeners.contains(pair))
            editorListeners.add(pair);
        return new Pair<>(editor, emml);
    }

    public static List<CSInfo> extractCSInfo(File file){
        List<CSInfo> csinfos = new ArrayList<CSInfo>();
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            //normalize, so that text doesn't get parsed into separate nodes
            doc.getDocumentElement().normalize();
            //System.out.println(doc);
            System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("subexprs");

            //LinkedList<DSInfo> dsInfo = new LinkedList<DSInfo>();
            System.out.println(nList.getLength());
            for (int temp = 0; temp < nList.getLength(); temp++) {
                CSInfo csinfo;
                Node nNode = nList.item(temp);

                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;

                    //System.out.println("Staff id : " + eElement.getAttribute("id"));
                    String expression = eElement.getElementsByTagName("subexpr").item(0).getTextContent();
                    NodeList exprsList = eElement.getElementsByTagName("node");
                    List<Statement> stms = new ArrayList<Statement>();
                    for (int i = 0; i < exprsList.getLength(); i++) {
                        Node node = exprsList.item(i);
                        if (node.getNodeType() == Node.ELEMENT_NODE) {

                            Element statement = (Element) node;
                            Statement stm;
                            String filename = statement.getElementsByTagName("filename").item(0).getTextContent();
                            ;
                            int loc = Integer.parseInt(statement.getElementsByTagName("loc").item(0).getTextContent());
                            stm = new Statement(loc, filename);
                            stms.add(stm);
                            System.out.println("filename: " + filename);
                            System.out.println("loc: " + loc);
                        }
                    }
                    if (stms.size() >= 2) {
                        csinfo = new CSInfo(expression, stms);
                        csinfos.add(csinfo);
                    }

                }
            }
            return csinfos;


        }catch (Exception ex) {
            System.out.println("Weird stuff happening..." + ex);
            Messages.showMessageDialog("Weird stuff happening..." + ex, "Info Box", Messages.getInformationIcon());
            return null;
        }

    }

    public static List<DSInfo> extractDSInfo(File file){
        List<DSInfo> dsinfos = new ArrayList<DSInfo>();
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            //normalize, so that text doesn't get parsed into separate nodes
            doc.getDocumentElement().normalize();
            //System.out.println(doc);
            System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("dead_store_pairs");

            //LinkedList<DSInfo> dsInfo = new LinkedList<DSInfo>();
            System.out.println(nList.getLength());
            for (int temp = 0; temp < nList.getLength(); temp++) {
                DSInfo dsinfo;
                Node nNode = nList.item(temp);

                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;
                    List<Statement> stms = new ArrayList<Statement>();
                    //System.out.println("Staff id : " + eElement.getAttribute("id"));
                    NodeList exprsList = eElement.getElementsByTagName("node");
                    for (int i = 0; i < exprsList.getLength(); i++) {
                        Node node = exprsList.item(i);
                        if (node.getNodeType() == Node.ELEMENT_NODE) {

                            Element statement = (Element) node;
                            Statement stm;
                            String filename = statement.getElementsByTagName("filename").item(0).getTextContent().trim();
                            int loc = Integer.parseInt(statement.getElementsByTagName("loc").item(0).getTextContent().trim());
                            stm = new Statement(loc, filename);
                            System.out.println("filename: " + filename);
                            System.out.println("loc: " + loc);
                            stms.add(stm);
                        }
                    }
                    if (stms.size() == 2) {
                        int loc1 = stms.get(0).getStatement();
                        int loc2 = stms.get(1).getStatement();
                        String filename1 = stms.get(0).getFilename();
                        String filename2 = stms.get(1).getFilename();
                        dsinfo = new DSInfo(loc1, loc2, filename1);
                        dsinfo.setFilename2(filename2);
                        dsinfos.add(dsinfo);
                    }

                }
            }



        }catch (Exception ex) {
            System.out.println("Weird stuff happening..." + ex);
            Messages.showMessageDialog("Weird stuff happening..." + ex, "Info Box", Messages.getInformationIcon());
            return null;
        }

        System.out.print("dsinfo"+ dsinfos.size());

        return dsinfos;
    }
    public static List<RDInfo> extractRDInfos(File file){
        List<RDInfo> rdinfos = new ArrayList<RDInfo>();
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            //normalize, so that text doesn't get parsed into separate nodes
            doc.getDocumentElement().normalize();
            //System.out.println(doc);
            //System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
            //Node ns = doc.getDocumentElement().getFirstChild();
            NodeList nList = doc.getDocumentElement().getChildNodes();

            for (int i = 0; i < nList.getLength(); i++) {
                Node node = nList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element eNode = (Element) node;
                    String table = eNode.getNodeName();
                    String aus = eNode.getAttributes().getNamedItem("actual_used_size").getTextContent();
                    int actual_used_size = Integer.parseInt(aus);
                    String tfs = eNode.getAttributes().getNamedItem("totalFieldSize").getTextContent();
                    int totalFieldSize = Integer.parseInt(tfs);
                    String filename = eNode.getElementsByTagName("filename").item(0).getTextContent();
                    int loc = Integer.parseInt(eNode.getElementsByTagName("loc").item(0).getTextContent());
                    Statement stm = new Statement(loc, filename);
                    String unused_field = eNode.getElementsByTagName("unused_field").item(0).getTextContent();
                    String used_field = eNode.getElementsByTagName("used_field").item(0).getTextContent();
                    RDInfo rdinfo = new RDInfo(totalFieldSize, actual_used_size, stm, unused_field, used_field, table);
                    rdinfo.self_print();
                    rdinfos.add(rdinfo);
                }

            }
        }catch (Exception ex) {
            System.out.println("Weird stuff happening..." + ex);
            Messages.showMessageDialog("Weird stuff happening..." + ex, "Info Box", Messages.getInformationIcon());
            return null;
        }

        return rdinfos;
    }

    public static List<LoopInfo> extractLIInfo(File file){
        List<LoopInfo> loopInfo = new ArrayList<LoopInfo>();
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            //normalize, so that text doesn't get parsed into separate nodes
            doc.getDocumentElement().normalize();
            //System.out.println(doc);
            System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("loopInvariant");

            for (int temp = 0; temp < nList.getLength(); temp++) {

                Node nNode = nList.item(temp);

                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;

                    //System.out.println("Staff id : " + eElement.getAttribute("id"));
                    String start = eElement.getElementsByTagName("start").item(0).getTextContent();
                    System.out.println("Loop Start: " + start);
                    int rstart = Integer.parseInt(start);
                    String startFilename = eElement.getElementsByTagName("startFilename").item(0).getTextContent();
                    System.out.println("Loop startFilename: " + startFilename);
                    String statement = eElement.getElementsByTagName("statement").item(0).getTextContent();
                    int rstatement = Integer.parseInt(statement);
                    System.out.println("Statement to Change: " + statement);
                    String filename = eElement.getElementsByTagName("filename").item(0).getTextContent();
                    System.out.println("File name: " + filename);
                    LoopInfo lf = new LoopInfo(rstart, startFilename, rstatement, filename);
                    if(!loopInfo.contains(lf)) {
                        loopInfo.add(lf);
                    }

                }
            }

        System.out.println("LISIZE" + loopInfo.size());
        }catch (Exception ex) {
            System.out.println("Weird stuff happening..." + ex);
            return null;
        }

        return loopInfo;
    }
    public static List<IRInfo> extractIRInfo(File file){
        List<IRInfo> irfs = new ArrayList<IRInfo>();

        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            //normalize, so that text doesn't get parsed into separate nodes
            doc.getDocumentElement().normalize();
            //System.out.println(doc);
            System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("inefficientRender");

            //LinkedList<DSInfo> dsInfo = new LinkedList<DSInfo>();

            for (int temp = 0; temp < nList.getLength(); temp++) {
                IRInfo irf = new IRInfo();
                Node nNode = nList.item(temp);

                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;

                    //System.out.println("Staff id : " + eElement.getAttribute("id"));
                    String tstatement = eElement.getElementsByTagName("statement").item(0).getTextContent();
                    String tempstate = tstatement.replaceAll("\\s+", "");
                    int rstate = Integer.parseInt(tempstate);
                    System.out.println("Statement: " + rstate);
                    String tfilename = eElement.getElementsByTagName("filename").item(0).getTextContent();
                    String filename = tfilename.replaceAll("\\s+", "");
                    int start = Integer.parseInt(eElement.getElementsByTagName("start").item(0).getTextContent());
                    String startfn = eElement.getElementsByTagName("startFilename").item(0).getTextContent();
                    String args = eElement.getElementsByTagName("args").item(0).getTextContent();
                    System.out.println("File name: " + filename);
                    irf.setFilename(filename);
                    irf.setStatement(rstate);
                    irf.setStart(start);
                    irf.setStartFilename(startfn);
                    irf.setArgs(args);
                    if(!irfs.contains(irf))
                        irfs.add(irf);

                }
            }

        }catch (Exception ex) {
            System.out.println("Weird stuff happening..." + ex);
            Messages.showMessageDialog("Weird stuff happening..." + ex, "Info Box", Messages.getInformationIcon());
            return null;
        }
        return irfs;
    }


    public static IssuePanel constructLIPanel(List<LoopInfo> liInfos){
        IssuePanel ip = new IssuePanel();
        ip.issueBtns = new ArrayList<>();
        for(LoopInfo lp: liInfos){
            String btnMsg = lp.getFilename() + " " + (liInfos.indexOf(lp) + 1);
            JButton bt = new JButton(btnMsg);
            ip.issueBtns.add(bt);
        }
        ip.createFixBtns();
        ip.addToPanel();
        return ip;
    }
    public static IssuePanel constructIRPanel(List<IRInfo> irInfos){
        IssuePanel ip = new IssuePanel();
        ip.issueBtns = new ArrayList<>();
        for(IRInfo lp: irInfos){
            String btnMsg = lp.getFilename() + " " +(irInfos.indexOf(lp) + 1);
            JButton bt = new JButton(btnMsg);
            ip.issueBtns.add(bt);
        }
        ip.createFixBtns();
        ip.addToPanel();
        return ip;
    }

    public static IssuePanel constructDSPanel(List<DSInfo> dsInfos){
        IssuePanel ip = new IssuePanel();
        ip.issueBtns = new ArrayList<>();
        for(DSInfo lp: dsInfos){
            String btnMsg = lp.getFilename1() + " " + (dsInfos.indexOf(lp) + 1);
            JButton bt = new JButton(btnMsg);
            ip.issueBtns.add(bt);
        }
        ip.createFixBtns();
        ip.addToPanel();
        return ip;
    }
    public static IssuePanel constructCSPanel(List<CSInfo> csInfos){
        IssuePanel ip = new IssuePanel();
        ip.issueBtns = new ArrayList<>();
        for(CSInfo lp: csInfos){
            Statement st = lp.getExprs().get(0);
            String btnMsg = st.getFilename()+ " " + (csInfos.indexOf(lp) + 1);
            JButton bt = new JButton(btnMsg);
            ip.issueBtns.add(bt);
        }
        ip.createFixBtns();
        ip.addToPanel();
        return ip;
    }
    public static IssuePanel constructRDPanel(List<RDInfo> rdInfos){
        IssuePanel ip = new IssuePanel();
        ip.issueBtns = new ArrayList<>();
        for(RDInfo lp: rdInfos){
            String btnMsg = lp.getStm().getFilename() + " " + (rdInfos.indexOf(lp) + 1);
            JButton bt = new JButton(btnMsg);
            ip.issueBtns.add(bt);
        }
        ip.createFixBtns();
        ip.addToPanel();
        return ip;
    }

    public static void updateLI(List<LoopInfo> loopInfos, String fn, int start, int loc){
         for(LoopInfo loopInfo: loopInfos){
            if(loopInfo.getstartFilename().equals(fn)){
                if(loopInfo.getStart() == loc ) {
                    loopInfo.setStart(start);
                }
                else if(loopInfo.getStart() >= start){
                    loopInfo.setStart(loopInfo.getStart() + 1);
                }
            }

            System.out.println("Before: " + loopInfo.getStatement());
            if(loopInfo.getFilename().equals(fn)){
                if(loopInfo.getStatement() == loc ) {
                    loopInfo.setStatement(start);
                }
                else if(loopInfo.getStatement() >= start ){
                    loopInfo.setStatement(loopInfo.getStatement() + 1);
                }
            }

            System.out.println("After: " + loopInfo.getStatement());
        }
    }

    public static void updateIR(List<IRInfo> irInfos, String fn, int start, int loc){
        for(IRInfo irInfo: irInfos){
            if(irInfo.getFilename().equals(fn)){
                if(irInfo.getStatement() == loc){
                    irInfo.setStatement(start);
                }
                else if(irInfo.getStatement() >= start ){
                    irInfo.setStatement(irInfo.getStatement() + 1);
                }
            }
            if(irInfo.getStartFilename().equals(fn)){
                if(irInfo.getStart() == loc){
                    irInfo.setStart(start);
                }
                else if(irInfo.getStart() >= start ){
                    irInfo.setStart(irInfo.getStart() + 1);
                }
            }

        }
    }

    public static void updateCS(List<CSInfo> csInfos, String fn, int start, int loc){
        for(CSInfo csInfo: csInfos){
            for(Statement st: csInfo.getExprs()) {
                if (st.getFilename().equals(fn)) {
                    if (st.getStatement() == loc) {
                        st.setStatement(start);
                    }
                    else if (st.getStatement() >= start) {
                        st.setStatement(st.getStatement() + 1);
                    }
                }
            }
        }

    }

    public static void updateDS(List<DSInfo> dsInfos, String fn, int start, int loc){
        for(DSInfo dsInfo: dsInfos){
            if (dsInfo.getFilename1().equals(fn)) {
                if (dsInfo.getLoc1() == loc) {
                    dsInfo.setLoc1(start);
                }
                else if (dsInfo.getLoc1() >= start) {
                    dsInfo.setLoc1(dsInfo.getLoc1() + 1);
                }
            }
            if (dsInfo.getFilename2().equals(fn)) {
                if (dsInfo.getLoc2() == loc) {
                    dsInfo.setLoc2(start);
                }
                else if (dsInfo.getLoc2() >= start) {
                    dsInfo.setLoc2(dsInfo.getLoc2() + 1);
                }
            }

        }

    }
    public static void updateRD(List<RDInfo> rdInfos, String fn, int start, int loc){
        for(RDInfo rdInfo: rdInfos){
            Statement st = rdInfo.getStm();
            if (st.getFilename().equals(fn)) {
                if (st.getStatement() == loc) {
                    st.setStatement(start);
                } else if (st.getStatement() >= start) {
                    st.setStatement(st.getStatement() + 1);
                }
            }
        }

    }
    public static void removeHighlighters(Project project){
        for (Pair<Editor, EditorMouseMotionListener> pair : editorListeners){
            try {
                pair.getKey().removeEditorMouseMotionListener(pair.getValue());
            } catch (Throwable e) {

            }

        }
        editorListeners = new ArrayList<Pair<Editor, EditorMouseMotionListener>>();
        Editor e = FileEditorManager.getInstance(project).getSelectedTextEditor();
        if(e != null) {
            e.getMarkupModel().removeAllHighlighters();
        }
    }
    public static String getRP(Project project){
        String results_path;
        String lib = Constant.pwlib;
        String root  = "static-analyzer/";
        IdeaPluginDescriptor plugin = PluginManager.getPlugin(PluginId.getId("com.intellij.powerstation"));
        String powerstation_path = plugin.getPath().toString();
        // get the version of the plugin in order to get the snapshot's name
        String version = plugin.getVersion();
        String name = plugin.getName();
        String snapshot = name + "-" + version + ".jar";

        String[] jarnames = powerstation_path.split("/");
        String jarname = jarnames[jarnames.length - 1];
        powerstation_path = powerstation_path.replace(jarname, "");
        System.out.println("path of powerstation is " + powerstation_path);
        System.out.println("snapshot name is :" + snapshot);

        String path_ana = powerstation_path + lib + root; //static-analyzer/analyze.sh
        String applications = path_ana + "/applications";

        String basedir = project.getBasePath();
        String input = basedir;
        String[] appnames = input.split("/");
        String app = "PW-" + appnames[appnames.length - 1];
        results_path =  applications + "/" + app + "/results/";

        return results_path;
    }

    public static  void showToolWindows(AnActionEvent e, Project project){
        MainMenu mainMenu = new MainMenu(e);
        mainMenu.frame.add(mainMenu.rootComponent);
        Dimension dim  = Toolkit.getDefaultToolkit().getScreenSize();
        mainMenu.frame.setLocation(dim.width/2-mainMenu.frame.getSize().width/2, dim.height/2-mainMenu.frame.getSize().height/2);
        mainMenu.frame.pack();
        final ToolWindow refactor_window = ToolWindowManager.getInstance(project).getToolWindow("powerstation");
        refactor_window.activate(new Runnable() {
            @Override
            public void run() {
                ContentFactory contentFactory = ContentFactory.SERVICE.getInstance();
                Content content = contentFactory.createContent(mainMenu.rootComponent, "Issues", false);
                refactor_window.getContentManager().removeAllContents(true);
                refactor_window.getContentManager().addContent(content);
                System.out.println("Added Content");
            }
        });
    }
    public static void runAnalysis(AnActionEvent event, String c_a){
        String results_path;
        Project project = event.getProject();
        if (project == null) return;
        String projectName = project.getName();
        StringBuilder sourceRootsList = new StringBuilder();
        VirtualFile[] vFiles = ProjectRootManager.getInstance(project).getContentSourceRoots();
        for (VirtualFile file : vFiles) {
            sourceRootsList.append(file.getUrl()).append("\n");

        }
        //System.out.println("current work directory is : " + PluginManager.getPlugin(PluginId.getId("com.intellij.powerstation")).getPath() );
        //System.out.println(PathManager.getPluginsPath());
        String lib = Constant.lib;
        String root  = "static-analyzer/";
        String pre = "preprocess_views/";
        String application = "applications";
        IdeaPluginDescriptor plugin = PluginManager.getPlugin(PluginId.getId("com.intellij.powerstation"));
        String powerstation_path = plugin.getPath().toString();
        // get the version of the plugin in order to get the snapshot's name
        String version = plugin.getVersion();
        String name = plugin.getName();
        String snapshot = name + "-" + version + ".jar";
        powerstation_path = powerstation_path.replace(snapshot, "");
        System.out.println("path of powerstation is " + powerstation_path);
        System.out.println("snapshot name is :" + snapshot);

        String path_lib = powerstation_path + lib;
        String path_ana = powerstation_path + lib + root; //static-analyzer/analyze.sh
        String script_ana_name = "analyze.sh";
        String single_action = "single_action.sh";
        String authorize = "chmod +x ";
        String authorize_ana = authorize + script_ana_name;
        String authorzie_single = authorize + single_action;
        String applications = path_ana + "/applications";
        String path_extract_ruby = path_ana + "/" + pre;
        String script_extract_ruby_name = "extract_ruby";
        String authorize_extract_ruby = authorize + script_extract_ruby_name;

        String script = "./" + script_ana_name;
        String basedir = event.getProject().getBasePath();
        String input = basedir;
        String[] appnames = input.split("/");
        String app = "PW-" + appnames[appnames.length - 1];
        //String app = "pw-blog"; //customize with user app name
        String run_script = script + " " + app + " " + input;
        String result_path = path_ana + "finish.txt";
        String unzip =  "jar xf " + snapshot;
        results_path =  applications + "/" + app + "/results/";
        String single_action_run = "./" + single_action  + " " + app + " " + c_a;
        try {
            // unzip the jar file to get the shell and other files
            //Analyze.runCommand("/home/junwen/", jruby);
            if(c_a != null){
                RunShell.runCommand(path_ana, authorzie_single);
                RunShell.runCommand(path_ana, single_action_run);
            }
            else {
                RunShell.runCommand(path_lib, unzip);
                // authorize analyze sh and the extract ruby file
                RunShell.runCommand(path_ana, authorize_ana);

                RunShell.runCommand(path_extract_ruby, authorize_extract_ruby);

                // analysis
                File f = new File(result_path);
                //Analyze.runCommand(path_ana, jruby);
                if (!f.exists())
                    RunShell.runCommand(path_ana, run_script);
            }
        }
        catch(IOException e){
            System.out.println("IO EXCEPTION");
        }
        catch(InterruptedException ie){
            System.out.println("InterruptedException happened");
        }
    }

}
