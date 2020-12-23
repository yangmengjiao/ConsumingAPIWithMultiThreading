//
//  CovidTableViewController.swift
//  ConsumingAPIWithMultiThreading
//
//  Created by mengjiao on 12/23/20.
//

import UIKit

class CovidTableViewController: UITableViewController {
    
    // daily covid datas
    var dailyDatas = [CovidDailyData]()
    
    // time series covid datas
    var timeSeriesDatas = [AfghanistanData]()
    
    // all covid datas
    var allDatas = [AllCovidData]()
    
    // ui for loading...
    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if navigationController?.tabBarItem.tag == 0 {
            //daily
           prepareDailyData()
        } else if navigationController?.tabBarItem.tag == 1 {
           // timeseries
            prepareTimeSeriesData()
        } else {
            // all data
            prepareAllCovidData()
        }
        
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
        self.navigationController?.navigationBar.topItem?.title = "Covid Datas"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if navigationController?.tabBarItem.tag == 0 {
            //daily
            return dailyDatas.count
        } else if navigationController?.tabBarItem.tag == 1 {
           // timeseries
            return timeSeriesDatas.count
        } else {
            // all data
            return allDatas.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CovidCell", for: indexPath)
        
        
        if navigationController?.tabBarItem.tag == 0 {
            //daily
            cell.textLabel?.text = dailyDatas[indexPath.row].state
        } else if navigationController?.tabBarItem.tag == 1 {
           // timeseries
            cell.textLabel?.text = String(timeSeriesDatas[indexPath.row].deaths)
        } else {
            // all data
            cell.textLabel?.text = String(allDatas[indexPath.row].delta?.confirmed ?? 0)
        }
        
        return cell
    }
    
    //MARK：- Help Functions
    
    // prepare datas for TimeSerie
    func prepareTimeSeriesData(){
        NetWorkingEngine.request(endpoint: CovidTrackingEndpoint.getTimeseriesList) { (result: Result<TimeSeriesData, Error>) in
            switch result {
            case .success(let data):

                self.timeSeriesDatas = data.Afghanistan
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.showActivityIndicator(show: false)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
  
    // prepare  Daily data
    func prepareDailyData(){
        NetWorkingEngine.request(endpoint: CovidTrackingEndpoint.getDailyList) { (result: Result<[CovidDailyData], Error>) in
            switch result {
            case .success(let datas):

                self.dailyDatas = datas
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.showActivityIndicator(show: false)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // prepare all covid data
    func prepareAllCovidData(){
        NetWorkingEngine.request(endpoint: CovidTrackingEndpoint.getAllDataList) { (result: Result<[String : [String : AllCovidData]], Error>) in
            switch result {
            case .success(let datas):
                
                for dict in datas.values {
                    for (_,value) in dict {
                        self.allDatas += [value]
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.showActivityIndicator(show: false)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK：- ActivityIndicator Functions
    
    fileprivate func setActivityIndicator() {
        // Configure the background containerView for the indicator
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = view.center.x
        activityIndicatorContainer.center.y = view.center.y
        
        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainer.addSubview(activityIndicator)
        view.addSubview(activityIndicatorContainer)
        
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
    }
    
    // Helper function to control activityIndicator's animation
    fileprivate func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.removeFromSuperview()
        }
    }
    
    
}

