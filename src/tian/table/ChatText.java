package tian.table;

public class ChatText {
    private Long id;
    private Long sendId;
    private Long receId;
    private String  content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSendId() {
        return sendId;
    }

    public void setSendId(Long sendId) {
        this.sendId = sendId;
    }

    public Long getReceId() {
        return receId;
    }

    public void setReceId(Long receId) {
        this.receId = receId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
