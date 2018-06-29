public class IRInfo {

    private int statement;
    private String filename;
    private int start;
    private String startFilename;
    private String args;
    public IRInfo(){
        this.statement = -1;
        this.filename = "";
    }

    public IRInfo(int line, String fname){
        this.statement = line;
        this.filename = fname;
    }

    public int getStatement(){
        return this.statement;
    }

    public void setStatement(int tstate){
        this.statement = tstate;
    }

    public String getFilename(){
        return this.filename;
    }

    public void setFilename(String fname2){
        this.filename = fname2;
    }

    public int getStart() {

        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public String getStartFilename() {
        return startFilename;
    }

    public void setStartFilename(String startFilename) {
        this.startFilename = startFilename;
    }

    public String getArgs() {
        return args;
    }

    public void setArgs(String args) {
        this.args = args;
    }
}
