package tian.table;


import java.sql.Timestamp;


public class Record {
    private Long id;
    private Long userId;
    private Long itemId;
    private int itemState;
    private Timestamp date;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
   private Long  formNumber;
   private int formState;
    private String tele;
    private String addr;

    public String getTele() {
        return tele;
    }

    public void setTele(String tele) {
        this.tele = tele;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    private String selType;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }












  private int selNumber;
  private int star;
  private String comment;
    private String[] seSplit;

    public String[] getSeSplit() {
        return seSplit;
    }

    public void setSeSplit(String[] seSplit) {
        this.seSplit = seSplit;
    }

    public int getCommentState() {
        return commentState;
    }

    public void setCommentState(int commentState) {
        this.commentState = commentState;
    }

    public int getItemState() {
        return itemState;
    }

    public void setItemState(int itemState) {
        this.itemState = itemState;
    }

    public Long getFormNumber() {
        return formNumber;
    }

    public void setFormNumber(Long formNumber) {
        this.formNumber = formNumber;
    }

    public int getFormState() {
        return formState;
    }

    public void setFormState(int formState) {
        this.formState = formState;
    }

    public String getSelType() {
        return selType;
    }

    public void setSelType(String selType) {
        this.selType = selType;
    }

    public int getSelNumber() {
        return selNumber;
    }

    public void setSelNumber(int selNumber) {
        this.selNumber = selNumber;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    private int commentState;

}
