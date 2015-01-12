
package com.xhr.service;

import java.util.List;

import com.xhr.entity.FollowUpSuggestion;
import com.xhr.entity.user.Doctor;
import com.xhr.model.Suggestion;

public interface IFollowUpSuggestionService extends IGenericService<FollowUpSuggestion> {

    public List<Suggestion> getSuggestions(Doctor doctor);

}
