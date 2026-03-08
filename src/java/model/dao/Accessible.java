/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.util.List;

/**
 *
 * @author di
 */

public interface Accessible<T> {
    int insertRec(T o);

    int updateRec(T o);

    int deleteRec(T o);

    List<T> listAll();

    T getObjectById(String id);
}

