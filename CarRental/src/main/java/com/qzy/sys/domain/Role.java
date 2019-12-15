package com.qzy.sys.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Role {
    private Integer roleid;

    private String rolename;

    private String roledesc;

    private Integer available;

}