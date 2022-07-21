package project.app.model;

public class BookCopy {
    private int dbId;
    private int bookEntryId;
    private String serialId;
    private String status;
    private int purchasePrice;
    public int getDbId() {
        return dbId;
    }
    public void setDbId(int dbId) {
        this.dbId = dbId;
    }
    public int getBookEntryId() {
        return bookEntryId;
    }
    public void setBookEntryId(int bookEntryId) {
        this.bookEntryId = bookEntryId;
    }
    public String getSerialId() {
        return serialId;
    }
    public void setSerialId(String serialId) {
        this.serialId = serialId;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public int getPurchasePrice() {
        return purchasePrice;
    }
    public void setPurchasePrice(int purchasePrice) {
        this.purchasePrice = purchasePrice;
    }
    @Override
    public String toString() {
        return "BookCopy [bookEntryId=" + bookEntryId + ", dbId=" + dbId + ", purchasePrice=" + purchasePrice
                + ", serialId=" + serialId + ", status=" + status + "]";
    }
}
