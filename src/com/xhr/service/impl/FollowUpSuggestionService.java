
package com.xhr.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.controller.doctor.DoctorIndexController;
import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.FollowUpSuggestion;
import com.xhr.entity.user.Doctor;
import com.xhr.model.Suggestion;
import com.xhr.service.IFollowUpSuggestionService;

@Component
public class FollowUpSuggestionService extends GenericService<FollowUpSuggestion> implements IFollowUpSuggestionService {

    private static final Logger LOG = Logger.getLogger(FollowUpSuggestionService.class);

    @Autowired
    GenericDao<FollowUpSuggestion> suggestionDao;

    @Override
    GenericDao<FollowUpSuggestion> getDao() {
        return suggestionDao;
    }

    @Override
    public List<Suggestion> getSuggestions(Doctor doctor) {
        List<FollowUpSuggestion> fs = suggestionDao.getBy("doctor.id", doctor.getId());
        List<Suggestion> suggestions = new ArrayList<Suggestion>();
        LOG.info("suggestion number: " + fs.size());
        for (FollowUpSuggestion sug : fs) {
            Suggestion suggestion = new Suggestion();
            suggestion.setPatientName(sug.getPatient().getUserName());
            suggestion.setReason(sug.getReason());
            suggestions.add(suggestion);
        }
        return suggestions;

    }

}
