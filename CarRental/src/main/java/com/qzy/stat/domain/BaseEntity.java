package com.qzy.stat.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BaseEntity {

    private String name;
    private Integer value;
}
