
package com.xhr.job;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.xhr.entity.FollowUpSuggestion;
import com.xhr.entity.SuggestionReason;
import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.service.IExecuteService;
import com.xhr.service.IFollowUpSuggestionService;
import com.xhr.service.IUserService;

@Component
public class FollowUpSuggestionJob implements IFollowUpSuggestionJob {

    private static final Logger LOG = Logger.getLogger(FollowUpSuggestionJob.class);

    @Autowired
    IExecuteService excuteService;

    @Autowired
    IUserService userService;

    @Autowired
    IFollowUpSuggestionService suggestionService;

    @Override
    @Scheduled(cron = "0 0 1 * * *")
    public void service() {
        LOG.info("This is job test");

        List<String> lastSevenDays = new ArrayList<String>();
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        for (int i = 0; i < 7; i++) {
            lastSevenDays.add(format.format(cal.getTime()));
            cal.add(Calendar.DATE, -1);
        }

        List<String> lastFourFriay = new ArrayList<String>();
        cal = Calendar.getInstance();
        int weekDay = cal.get(Calendar.DAY_OF_WEEK) + 1;
        if (weekDay < 7) {
            cal.add(Calendar.DATE, -weekDay);
        } else {
            cal.add(Calendar.DATE, 7 - weekDay);
        }
        for (int i = 0; i < 4; i++) {
            lastFourFriay.add(format.format(cal.getTime()));
            cal.add(Calendar.DATE, -7);
        }

        @SuppressWarnings("rawtypes")
        List patients = userService.getAll(Role.PATIENT);
        SuggestionReason reason;
        LOG.info("patients size = " + patients.size());
        for (int i = 0; i < patients.size(); i++) {
            Patient patient = (Patient) patients.get(i);
            List<ExecuteRecord> fridaysRecords = excuteService.getRecordByDates(patient, lastFourFriay);
            List<ExecuteRecord> sevenDaysRecords = excuteService.getRecordByDates(patient, lastSevenDays);
            LOG.info("=========");
            LOG.info(patient.getUserName());
            LOG.info(fridaysRecords.size());
            LOG.info(sevenDaysRecords.size());
            LOG.info(patient.getDoctors().size());
            LOG.info("=========");
            if (fridaysRecords.size() < 2 || sevenDaysRecords.size() < 4) {

                if (fridaysRecords.size() < 2) {
                    if (sevenDaysRecords.size() < 4) {
                        reason = SuggestionReason.FS;
                    } else {
                        reason = SuggestionReason.FL;
                    }
                } else {
                    reason = SuggestionReason.SL;
                }

                for (Doctor doctor : patient.getDoctors()) {
                    LOG.info("=========");
                    LOG.info("doctor name = " + doctor.getUserName());
                    LOG.info("=========");
                    FollowUpSuggestion sug = new FollowUpSuggestion();
                    sug.setDoctor(doctor);
                    sug.setPatient(patient);
                    sug.setReason(reason);
                    suggestionService.save(sug);
                }

            }

        }

    }

}
