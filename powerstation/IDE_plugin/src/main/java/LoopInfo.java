public class LoopInfo {
    //I thought having a class like this would help, but I guess I
    //don't really know that.
    private int start;
    private int statement;
    private String filename;
    private String startFilename;
    private boolean fixed;
    public LoopInfo(int start, String startFilename, int statement, String filename){
        this.start = start;
        this.startFilename = startFilename;
        this.statement = statement;
        this.filename = filename;
    }

    public int getStart(){
        return this.start;
    }

    public void setStart(int star){
        this.start = star;
    }

    public String getstartFilename(){
        return this.startFilename;
    }

    public void setstartFilename(String sfname){
        this.startFilename = sfname;
    }

    public int getStatement(){
        return this.statement;
    }

    public void setStatement(int stat){
        this.statement = stat;
    }
    public String getFilename(){
        return this.filename;
    }

    public void setFilename(String fname){
        this.filename = fname;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof LoopInfo){
            LoopInfo li =  (LoopInfo) obj;
            return li.getFilename().equals(this.filename) && li.getStatement() == this.getStatement();
        }
        return super.equals(obj);
    }

    public String getStartFilename() {
        return startFilename;
    }

    public void setStartFilename(String startFilename) {
        this.startFilename = startFilename;
    }

    public boolean isFixed() {
        return fixed;
    }

    public void setFixed(boolean fixed) {
        this.fixed = fixed;
    }
}


