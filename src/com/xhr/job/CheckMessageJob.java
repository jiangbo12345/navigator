
package com.xhr.job;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.xhr.entity.Message;
import com.xhr.entity.MessageType;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;
import com.xhr.service.IMessageService;
import com.xhr.service.IUserService;

@Component
public class CheckMessageJob implements ICheckMessageJob {

    private static final Logger LOG = Logger.getLogger(CheckMessageJob.class);

    @Autowired
    IUserService userService;

    @Autowired
    IMessageService messageService;

    @Override
    @Scheduled(cron = "0 0 1 * * *")
    public void checkSuggestion() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, -2);
        cal.add(Calendar.DATE, 2);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        LOG.info("register date = " + format.format(cal.getTime()));
        @SuppressWarnings("rawtypes")
        List patients = userService.getPatientsByRegisterDate(format.format(cal.getTime()));
        LOG.info("patients size = " + patients.size());
        for (int i = 0; i < patients.size(); i++) {
            Patient pa = (Patient) patients.get(i);
            messageService.save(createMessage("请记得两天后去医院进行痰检", pa));

            if (pa.getDoctors() != null && pa.getDoctors().size() > 0) {
                for (Doctor doctor : pa.getDoctors()) {
                    messageService.save(createMessage("请记得提醒 " + pa.getUserName() + " 两天后去医院进行痰检", doctor));
                }
            }

        }

        clearMessages();

    }

    private void clearMessages() {
        List<Message> messages = messageService.getSystemMessage("System");
        StringBuilder ids = new StringBuilder();
        for (Message message : messages) {
            if (outofDate(message.getCreateDate())) {
                if (ids.length() > 0) {
                    ids.append(",");
                }
                ids.append(message.getId());
            }
        }
        LOG.info("need clear message ids = " + ids);
        messageService.batchDelete(ids.toString());
    }

    private boolean outofDate(Date createDate) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -2);
        if (createDate == null || createDate.before(cal.getTime())) {
            return true;
        }
        return false;
    }

    private Message createMessage(String content, User touser) {
        Message message = new Message();
        message.setContent(content);
        message.setFrom(null);
        message.setSendTo(touser);
        message.setIsRead(false);
        message.setShowInIndex(true);
        message.setType(MessageType.TODO);
        message.setCreateBy("System");
        message.setCreateDate(Calendar.getInstance().getTime());
        return message;
    }
}
