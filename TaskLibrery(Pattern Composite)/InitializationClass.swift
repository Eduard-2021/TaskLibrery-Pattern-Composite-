//
//  InitializationClass.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

class InitializationClass {
    let generalTask = CollectionTask(task: "План и задачи на день")
    let firstTask = OneTask(task: "Помочь убрать в квартире")
    let secondTask = OneTask(task: "Сьездить к родителям")
    let thirdTask = CollectionTask(task: "Отремонтировать машину")
    let firstSubTaskThridTask = OneTask(task: "Отогнать машину на ремонт")
    let secondSubTaskThridTask = CollectionTask(task: "Купить необходимые запчасти")
    let firstSubTaskthirdSubTaskThridTask = OneTask(task: "Сьездить за запчастями на рынок")
    let secondSubTaskthirdSubTaskThridTask = OneTask(task: "Сьездить за запчастями в автомагазин")
    let thirdSubTaskThridTask = OneTask(task: "Привести необходимые запчасти")
    let forthSubTaskThridTask = OneTask(task: "Забрать машину с ремонта")
    let forthTask = OneTask(task: "Помыть машину")
    let fifthTask = OneTask(task: "Поехать отдохнуть с семьей")
    let sixthTask = CollectionTask(task: "Выучить с детьми уроки")
    let firstSubTaskSixthTask = OneTask(task: "Сделать уроки с младшим сыном")
    let secondSubTaskSixthTask = OneTask(task: "Сделать уроки со старшим сыном")
    let seventhTask = OneTask(task: "Посмотреть футбол")
    
    func initialization() {
        secondSubTaskThridTask.collectionTask = [firstSubTaskthirdSubTaskThridTask, secondSubTaskthirdSubTaskThridTask]
        sixthTask.collectionTask = [firstSubTaskSixthTask, secondSubTaskSixthTask]
        thirdTask.collectionTask = [firstSubTaskThridTask, secondSubTaskThridTask, thirdSubTaskThridTask, forthSubTaskThridTask]
        generalTask.collectionTask = [firstTask,
                                      secondTask,
                                      thirdTask,
                                      forthTask,
                                      fifthTask,
                                      sixthTask,
                                      seventhTask]
        ClassTaskForShow.shared.taskForShow = generalTask
    }
}
