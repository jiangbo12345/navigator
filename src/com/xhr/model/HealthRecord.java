
package com.xhr.model;

public class HealthRecord {

    private RecordType type;
    private String content;
    private String recordDate;

    public HealthRecord(RecordType type, String content, String recordDate) {
        this.type = type;
        this.content = content;
        this.recordDate = recordDate;
    }

    public RecordType getType() {
        return type;
    }

    public String getContent() {
        return content;
    }

    public String getRecordDate() {
        return recordDate;
    }

    public String getTypeMessage() {

        if (RecordType.Hypertension.equals(type)) {
            return "血压";
        } else if (RecordType.Medicine.equals(type)) {
            return "服药";
        }
        return "";

    }
}
