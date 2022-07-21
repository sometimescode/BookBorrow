package project.app.model;

import java.util.Date;

public class OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount {
    private int dbId;
    private int requesterId;
    private int requestedBookId;
    private String status;
    private Date requestDate;
    private Date statusUpdateDate;
    private int requestedCopyId;
    private String joinBookCopySerialId;
    private int joinCheckoutRecordId;
    private int joinBookEntryId;
    private String joinBookEntryISBN;
    private String joinBookEntryTitle;
    private String joinBookEntryCover;
    private String joinAccountFirstName;
    private String joinAccountLastName;
    
    public int getDbId() {
        return dbId;
    }
    public void setDbId(int dbId) {
        this.dbId = dbId;
    }
    public int getRequesterId() {
        return requesterId;
    }
    public void setRequesterId(int requesterId) {
        this.requesterId = requesterId;
    }
    public int getRequestedBookId() {
        return requestedBookId;
    }
    public void setRequestedBookId(int requestedBookId) {
        this.requestedBookId = requestedBookId;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getRequestDate() {
        return requestDate;
    }
    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }
    public Date getStatusUpdateDate() {
        return statusUpdateDate;
    }
    public void setStatusUpdateDate(Date statusUpdateDate) {
        this.statusUpdateDate = statusUpdateDate;
    }
    public int getRequestedCopyId() {
        return requestedCopyId;
    }
    public void setRequestedCopyId(int requestedCopyId) {
        this.requestedCopyId = requestedCopyId;
    }
    public String getJoinBookCopySerialId() {
        return joinBookCopySerialId;
    }
    public void setJoinBookCopySerialId(String joinBookCopySerialId) {
        this.joinBookCopySerialId = joinBookCopySerialId;
    }
    public int getJoinCheckoutRecordId() {
        return joinCheckoutRecordId;
    }
    public void setJoinCheckoutRecordId(int joinCheckoutRecordId) {
        this.joinCheckoutRecordId = joinCheckoutRecordId;
    }
    public int getJoinBookEntryId() {
        return joinBookEntryId;
    }
    public void setJoinBookEntryId(int joinBookEntryId) {
        this.joinBookEntryId = joinBookEntryId;
    }
    public String getJoinBookEntryISBN() {
        return joinBookEntryISBN;
    }
    public void setJoinBookEntryISBN(String joinBookEntryISBN) {
        this.joinBookEntryISBN = joinBookEntryISBN;
    }
    public String getJoinBookEntryTitle() {
        return joinBookEntryTitle;
    }
    public void setJoinBookEntryTitle(String joinBookEntryTitle) {
        this.joinBookEntryTitle = joinBookEntryTitle;
    }
    public String getJoinBookEntryCover() {
        return joinBookEntryCover;
    }
    public void setJoinBookEntryCover(String joinBookEntryCover) {
        this.joinBookEntryCover = joinBookEntryCover;
    }
    public String getJoinAccountFirstName() {
        return joinAccountFirstName;
    }
    public void setJoinAccountFirstName(String joinAccountFirstName) {
        this.joinAccountFirstName = joinAccountFirstName;
    }
    public String getJoinAccountLastName() {
        return joinAccountLastName;
    }
    public void setJoinAccountLastName(String joinAccountLastName) {
        this.joinAccountLastName = joinAccountLastName;
    }
    @Override
    public String toString() {
        return "OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount [dbId=" + dbId + ", joinAccountFirstName="
                + joinAccountFirstName + ", joinAccountLastName=" + joinAccountLastName + ", joinBookCopySerialId="
                + joinBookCopySerialId + ", joinBookEntryCover=" + joinBookEntryCover + ", joinBookEntryISBN="
                + joinBookEntryISBN + ", joinBookEntryId=" + joinBookEntryId + ", joinBookEntryTitle="
                + joinBookEntryTitle + ", joinCheckoutRecordId=" + joinCheckoutRecordId + ", requestDate=" + requestDate
                + ", requestedBookId=" + requestedBookId + ", requestedCopyId=" + requestedCopyId + ", requesterId="
                + requesterId + ", status=" + status + ", statusUpdateDate=" + statusUpdateDate + "]";
    }
}