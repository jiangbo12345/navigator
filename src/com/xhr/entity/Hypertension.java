
package com.xhr.entity;

import javax.persistence.Column;

public class Hypertension {

    @Column(length = 32)
    private String high;

    @Column(length = 32)
    private String low;

    public String getHigh() {
        return high;
    }

    public void setHigh(String high) {
        this.high = high;
    }

    public String getLow() {
        return low;
    }

    public void setLow(String low) {
        this.low = low;
    }

    public String getName() {
        return "高血压";
    }

    public void setName(String name) {
        name = "高血压";
    }

}
