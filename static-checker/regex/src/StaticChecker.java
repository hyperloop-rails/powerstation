import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javafx.util.Pair;
import java.nio.file.Files;
import java.nio.file.Paths;
public class StaticChecker {
    public static void main(String[] args) throws Exception{

        String filename = "/Users/jwy/Research/test";
        String writefile = "inefficientAPI.xml";
        if(args.length >= 1) {
            filename = args[0];
        }
        else{
            System.out.println("Usage: java -jar StaticChecker.jar folder");
            //System.exit(0);
        }

        File path = new File(filename);
        if(!path.exists()) {
            System.out.println(path + "Folder doesnt exist");
            System.exit(0);
        }

        String output = "<inefficiencies>\n" + traverseFolder(path) + "</inefficiencies>";

        BufferedWriter writer = new BufferedWriter(new FileWriter(writefile));
        writer.write(output);
        writer.close();
        //System.out.println(output);
    }
    public static List<Pair<String[], int[]>> extractMethods(String[] lines){
        List<Pair<String[], int[]>> methods = new ArrayList();
        int start = -1;
        Pattern p = Pattern.compile(".*.pluck([^()]*).*.sum");
        int[] indices = new int[lines.length];
        for(int i = 0; i < lines.length; i ++){
            indices[i] = i;
        }
        for(int i = 0; i < lines.length; i ++){
            String line = lines[i];
            if(line.trim().startsWith("def")){
                if(start != -1){
                    String[] block =    Arrays.copyOfRange(lines, start, i);
                    int[] index = Arrays.copyOfRange(indices, start, i);
                    Pair<String[], int[]> ml = new Pair(block, index);
                    methods.add(ml);
                    //System.out.println(lines.length + " " + indices.length);
                }
                start = i;
            }
            if(i == lines.length - 1){
                String[] block = Arrays.copyOfRange(lines, start, i + 1);
                int[] index = Arrays.copyOfRange(indices, start, i + 1);
                Pair<String[], int[]> ml = new Pair(block, index);
                methods.add(ml);

               // System.out.println(lines.length + " lll: " + indices.length);
            }
        }
        return methods;
    }
    public static String traverseFolder(File path) throws Exception{
        String output = "";
        File[] files = path.listFiles();
        for (int i = 0; i < files.length; i++){
            if (files[i].isFile()){ //this line weeds out other directories/folders
                //System.out.println(files[i]);
                String fp = files[i].getAbsolutePath();
                if(fp.endsWith(".rb")){
                    List <String> lines = Files.readAllLines(Paths.get(fp), StandardCharsets.UTF_8);
                    //System.out.println(lines);
                    String[] ls = lines.toArray(new String[lines.size()]);
                    //System.out.println(ls);
                    List<Pair<String[], int[]>> methods =  extractMethods(ls);

                    for(int j = 0; j < methods.size(); j ++){
                        Pair<String[], int[]> ml = methods.get(j);
                        List<Pair<PluckSum, List<PluckSum>>>  matches = matchSingleLine(ml);
                        String xml = generateXML(matches, fp);
                        String o = matchMap(ml, fp);
                        String o1 = matchFindCreate(ml, fp);
                        String o2 = matchUpdate(ml, fp);
                        String o3 = matchPatterns(ml, fp);

                        output += xml;
                        output += o ;
                        output += o1 ;
                        output += o2 ;
                        output += o3 ;
                    }
                }
            }
            if(files[i].isDirectory()){
                traverseFolder(files[i]);
            }
        }
        return output;
    }
    public static String generateXML(List<Pair<PluckSum, List<PluckSum>>> matches, String filename){
        String result = "";
        for(Pair<PluckSum, List<PluckSum>> pps: matches){
            result += "\t<plucksum>\n";
            result += "\t\t<filename>" + filename + "</filename>\n";
            PluckSum ps = pps.getKey();
            result += "\t\t<source>" + ps.getSource().trim() + "</source>\n";
            result += "\t\t<loc>" + (ps.getPluck().getLoc() + 1 ) + "</loc>\n";
            List<PluckSum> lps = pps.getValue();
            result += "\t\t<sum>\n";
            if(lps != null) {
                for (PluckSum sp : lps) {
                    result += "\t\t\t<source>" + sp.getSource().trim() + "</source>\n";
                    result += "\t\t\t<loc>" + (sp.getPluck().getLoc() + 1 )+ "</loc>\n";
                }
            }
            result += "\t\t</sum>\n";
            result += "\t</plucksum>\n";
        }
        return result;
    }
    public static  List<Pair<PluckSum, List<PluckSum>>>  matchSingleLine( Pair<String[], int[]> ml ){
        String[] block = ml.getKey();
        int[] index = ml.getValue();
        Pattern p = Pattern.compile(".pluck\\([^\\(\\)]+\\).*.sum");
        Pattern p1 = Pattern.compile(".pluck\\([^\\(\\)]+\\)");
        Pattern pll = Pattern.compile(".*([@$a-zA-Z]+).*=[^=]*.pluck\\([^\\(\\)]+\\)");
        List<Pair<String, Integer>> assigns = new ArrayList<>();
        List<Pair<PluckSum, List<PluckSum>>> assignSum = new ArrayList<>();
        for(int j = 0; j < block.length; j ++){
            String line = block[j];
            //System.out.println(line);
            Matcher m = p.matcher(line);
            Matcher mpluck = pll.matcher(line);
            while(mpluck.find()){
                int s = mpluck.start();
                int e = mpluck.end();
                String matchStr = line.substring(s, e);
                Pair<String, Integer> pair = new Pair(matchStr, j);
                assigns.add(pair);
            }
            while(m.find()){
                int s = m.start();
                int e = m.end();
                String matchStr = line.substring(s, e);
                //System.out.println("s: " + s + " e: " + e + " string: " + matchStr) ;
                Matcher m1 = p1.matcher(matchStr);
                while(m1.find()) {
                    int s1 = m1.start();
                    int e1 = m1.end();
                    //System.out.println("s: " + s1 + " e: " + e1 + " string: " + matchStr.substring(s1, e1));
                    String inbetween = matchStr.substring(e1, matchStr.length() - 4);
                    //System.out.println("inbetween " + inbetween);
                    int l1 = inbetween.replaceAll("\\(", "").length();
                    int l2 = inbetween.replaceAll("\\)", "").length();
                    if(l1 == l2){
                        String pluck = matchStr.substring(s1, e1);
                        String expr = pluck.substring(7, pluck.length() - 1);
                        if(!expr.contains(",")) {
                            //System.out.println(s + " " + (matchStr.length() - 4 + s) + " " + expr);
                            Triple pluckMatch = new Triple(j, ".pluck", s);
                            Triple sumMatch = new Triple(j, ".sum", s + matchStr.length() - 4 );
                            PluckSum ps = new PluckSum(pluckMatch, sumMatch, 0);
                            ps.setSource(matchStr);
                            assignSum.add(new Pair(ps, null));
                        }
                    }
                }
            }

        }
        for(Pair<String, Integer> pair: assigns){
            String matchExpr = pair.getKey();
            int loc = pair.getValue();
            int equal = matchExpr.indexOf("=");
            String variable = matchExpr.substring(0, equal - 1).trim();
            //System.out.println("matched: "  + matchExpr + loc + " " + equal + variable);
            Pattern pexpr = Pattern.compile("(" + variable + ").*");
            Pattern sumexpr = Pattern.compile("(" + variable + ").*.sum");
            Triple var = new Triple(loc, matchExpr, matchExpr.indexOf(variable));
            Triple def = new Triple(loc, matchExpr, matchExpr.indexOf(".pluck"));
            PluckSum psvd  = new PluckSum(var, def, 2);
            psvd.setSource(matchExpr);
            List<PluckSum> objectsums = new ArrayList<>();
            Pair<PluckSum, List<PluckSum>> assign2use= new Pair(psvd, objectsums);
            for(int j = loc + 1; j < block.length; j ++){
                String line = block[j];
                //System.out.println("check line: " + line);
                Matcher m = pexpr.matcher(line);
                boolean isMatchSum = false;
                boolean isMatchVariable = false;
                PluckSum ps ;
                while(m.find()){
                    int s = m.start();
                    int e = m.end();
                    String matchStr = line.substring(s, e);
                    //System.out.println("s1: " + s + " e1: " + e + " string: " + matchStr) ;
                    Matcher m1 = sumexpr.matcher(matchStr);
                    List<Triple> sums;
                    Triple variableMatch;
                    isMatchVariable = true;
                    variableMatch = new Triple(j, variable, s);
                    sums = new ArrayList<Triple>();
                    isMatchSum = false;
                    while(m1.find()) {
                        int s1 = m1.start();
                        int e1 = m1.end();
                        //System.out.println("s2: " + s1 + " e2: " + e1 + " string: " + matchStr.substring(s1, e1) + matchStr.length());
                        String inbetween = matchStr.substring(variable.length(), matchStr.length() - 4 );
                        //System.out.println("inbetween " + inbetween);
                        int l1 = inbetween.replaceAll("\\(", "").length();
                        int l2 = inbetween.replaceAll("\\)", "").length();
                        if(l1 == l2){
                            String pluck = matchStr.substring(s1, e1);
                            //System.out.println(s + " " + (matchStr.length() - 4 + s + s1) + " " + pluck);
                            isMatchSum = true;
                            Triple sumMatch = new Triple(j, ".sum", matchStr.length() - 4 + s + s1);
                            ps = new PluckSum(variableMatch, sumMatch, 3);
                            ps.setSource(matchStr);
                            objectsums.add(ps);
                            break;
                        }
                    }
                    if(!isMatchSum){
                       // System.out.println("not matched");
                        break;
                    }

                }
                if(isMatchVariable &&!isMatchSum){
                   // System.out.println("break out");
                    ps = null;
                    break;
                }
                if(j == block.length - 1 ){
                    assignSum.add(assign2use);
                }

            }
        }
        return assignSum;

    }
    public static String  matchPatterns(Pair<String[], int[]> ml, String filename){
        Pattern countGre = Pattern.compile(".*.count\\s*>\\s*0");
        Pattern wherefirst = Pattern.compile(".*wherer\\([^\\(\\)]*\\).*.first");
        Pattern group = Pattern.compile(".group\\([^\\(\\)]*\\).count");
        Pattern count = Pattern.compile(".*.count");
        Pattern pluckpluck = Pattern.compile("pluck\\(.*\\) \\+ pluck\\(.*\\)");
        Pattern[] ptns = new Pattern[]{countGre, count, group, wherefirst, pluckpluck};
        String output = "";
        String[] types = new String[]{"countlarger0", "wherefirst", "groupcount", "count", "pluckpluck"};
        String[] lines = ml.getKey();
        int[] indicies = ml.getValue();
        for(int j = 0; j < ptns.length; j ++){
            Pattern p = ptns[j];
            for(int i = 0 ; i < lines.length; i ++){
                String line = lines[i];
                Matcher m = p.matcher(line);
                while(m.find()){
                    int s = m.start();
                    int e = m.end();
                    output += "\t<" + types[j] + ">\n";
                    output += "\t\t<filename>" + line.substring(s, e) + "</filename>\n";
                    output += "\t\t<loc>" + (indicies[i] + 1 ) + "</loc>\n";
                    output += "\t</" + types[j] + ">\n";
                }
            }
        }
        return output;


    }
    public static String matchUpdate(Pair<String[], int[]> ml, String filename){
        String[] lines = ml.getKey();
        String output = "";
        Pattern p = Pattern.compile(".*.each\\s+do\\s+\\|.+\\|");
        int[] indices = ml.getValue();
        for(int i = 0 ; i < lines.length; i ++) {
            String line = lines[i];
            Matcher m = p.matcher(line);
            while (m.find()) {
                int s = m.start();
                int e = m.end();
                String matchString = line.substring(s, e);
                Pattern parg = Pattern.compile("\\|.+\\|");
                Matcher marg = parg.matcher(matchString);
                while(marg.find()){
                    int s1 = marg.start();
                    int e1 = marg.end();
                    String arg = matchString.substring(s1+1, e1-1);
                    Pattern pupdate = Pattern.compile(arg + ".update");
                    for(int j = i + 1; j < lines.length; j ++){
                        String newline = lines[j];
                        Matcher mupdate = pupdate.matcher(newline);
                        while(mupdate.find()){

                            output += "\t<updateall>\n";
                            output += "\t\t<loc>" + indices[(i + 1)] + "</loc>\n";
                            output += "\t\t<locupdate>" + indices[(j + 1)] + "</locupdate>\n";
                            output += "\t\t<source>" + matchString.trim() +  "</source>\n";
                            output += "\t\t<sourceupdate>" + newline.substring(mupdate.start(), mupdate.end()).trim() +  "</sourceupdate>";
                            output += "\t</updateall>\n";
                        }
                    }
                }
            }
        }
        return output;
    }

    public static String matchMap(Pair<String[], int[]> ml, String filename){
        String[] lines = ml.getKey();
        String output = "";
        Pattern p = Pattern.compile(".map\\([^\\(\\)]+\\)");
        int[] indices = ml.getValue();
        for(int i = 0 ; i < lines.length; i ++) {
            String line = lines[i];
            Matcher m = p.matcher(line);
            while (m.find()) {
                int s = m.start();
                int e = m.end();
                String matchString = line.substring(0, s);
                //System.out.println("matched" + matchString);
                String arg = matchString.substring(matchString.indexOf('=') + 1, matchString.length() ).trim();
               // System.out.println("matched2" + arg);
                Pattern pupdate = Pattern.compile("(" + arg + ")");
                for(int j = i - 1; j >= 0 ; j --){
                    String newline = lines[j];
                    Matcher mupdate = pupdate.matcher(newline);
                    while(mupdate.find()){
                       break;
                    }
                    if(j == 0){
                        output += "\t<map>\n";
                        output += "\t\t<loc>" + indices[(i + 1)] + "</loc>\n";
                        output += "\t\t<source>" + matchString.trim() +  ".map</source>\n";
                        output += "\t</map>\n";
                    }
                }

            }
        }
        return output;
    }
    public static String matchFindCreate(Pair<String[], int[]> ml, String filename){
        String[] lines = ml.getKey();
        String output = "";
        Pattern p = Pattern.compile("if\\s+.*.exists?");
        int[] indices = ml.getValue();
        for(int i = 0 ; i < lines.length; i ++) {
            String line = lines[i];
            Matcher m = p.matcher(line);
            while (m.find()) {
                int s = m.start();
                int e = m.end();
                String matchString = line.substring(s+2, line.indexOf('.')).trim();
               // System.out.println("matched" + matchString);
                    Pattern pupdate = Pattern.compile(matchString + ".find_by\\([^\\(\\)]+\\)");
                    for(int j = i + 1; j < lines.length; j ++){
                        String newline = lines[j];
                        Matcher mupdate = pupdate.matcher(newline);
                        Pattern pcreate = Pattern.compile(matchString + ".create\\([^\\(\\)]+\\)");
                        while(mupdate.find()){
                            //System.out.println("matched1" + newline);
                            for(int k = j + 1; k < lines.length; k ++){
                                String thirdline = lines[k];
                                Matcher mcreate = pcreate.matcher(thirdline);
                                while(mcreate.find()){
                                    output += "\t<findcreate>\n";
                                    output += "\t\t<loc>" + indices[(i + 1)] + "</loc>\n";
                                    output += "\t\t<locfind>" + indices[(j + 1)] + "</locfind>\n";
                                    output += "\t\t<loccreate>" + indices[(k + 1)] + "</loccreate>\n";
                                    output += "\t\t<source>" + matchString.trim() +  "</source>\n";
                                    output += "\t\t<sourcefind>" + newline.substring(mupdate.start(), mupdate.end()).trim() +  "</sourcefind>\n";
                                    output += "\t\t<sourcecreate>" + thirdline.substring(mcreate.start(), mcreate.end()).trim() +  "</sourcecreate>\n";
                                    output += "\t</findcreate>\n";
                                }
                            }

                        }

                    }
            }
        }
        return output;
    }
    public static List<String>  singleLine(String line, Pattern p ){
        Matcher m =  p.matcher(line);
        List<String> result = new ArrayList<>();
        while (m.find()) {
            int s = m.start();
            int e = m.end();
            result.add(line.substring(s, e));
        }
        return result;

    }
}
