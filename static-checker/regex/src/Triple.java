public class Triple {
    int loc;
    String expr;
    int offset;

    public Triple(int loc, String expr, int offset) {
        this.loc = loc;
        this.expr = expr;
        this.offset = offset;
    }

    public int getLoc() {
        return loc;
    }

    public void setLoc(int loc) {
        this.loc = loc;
    }

    public String getExpr() {
        return expr;
    }

    public void setExpr(String expr) {
        this.expr = expr;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
}
