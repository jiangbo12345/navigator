
package com.xhr.service;

import java.util.List;

import com.xhr.entity.Message;
import com.xhr.entity.user.User;

public interface IMessageService extends IGenericService<Message> {

    List<Message> getToDoList(User user);

    List<Message> getSystemMessage(String createBy);

    int batchDelete(String ids);

}
