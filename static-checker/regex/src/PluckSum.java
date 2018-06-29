import java.util.List;

public class PluckSum {
    Triple pluck;
    Triple sum;
    int type = 0;
    String source = "";
    // 0 means single line, 1 means cross line, 2 means assign pluck, 3 means xx.sum
    public Triple getPluck() {
        return pluck;
    }

    public void setPluck(Triple pluck) {
        this.pluck = pluck;
    }

    public Triple getSum() {
        return sum;
    }

    public void setSum(Triple sum) {
        this.sum = sum;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public PluckSum(Triple pluck, Triple sum, int type) {
        this.pluck = pluck;
        this.sum = sum;
        this.type = type;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
