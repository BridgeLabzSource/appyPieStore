//
//  MainControllerCommunicator.swift
//  APPYSTORE
//
//  Created by ios_dev on 29/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

protocol MainControllerCommunicator {
    func getContext() -> MainController
    func addChild(controller: BaseViewController, area: Area?, hideCurrentController: Bool)
    func setUIComponents(components: ComponentProperties?)
    func performBackButtonClick(_ controller: BaseViewController)
    func showProgressBar()
    func hideProgressBar()
    func refreshAllPages()
    func showCenterText(text: String?)
    func clearBackStack()
}
