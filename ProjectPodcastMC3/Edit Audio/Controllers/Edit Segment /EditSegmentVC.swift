//
//  EditSegmentVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 11/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

enum TypeSegment {
    case Edit, Start, End
}

struct SegmentModel {
    var startTimeSeconds: Int?
    var endTimeSeconds: Int?
}

struct TimeModel {
    var hours: Int?
    var minutes: Int?
    var seconds: Int?
}

class EditSegmentVC: UIViewController {
    
    @IBOutlet weak var editSegmentCV: UICollectionView!
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    var editSegmentView: EditSegmentView { return self.view as! EditSegmentView }
    
    var type: TypeSegment = .Edit
    
    var startTimeModel: TimeModel?
    var endTimeModel: TimeModel?
    
    var minutes: Int?
    var seconds: Int?
    
    override func loadView() {
        self.view = EditSegmentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        initInterfaceComponent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupNavigationController() {
        title = "Edit Segment Duration"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.clipsToBounds = false
        self.navigationController?.navigationBar.shadowImage = Colors.BG_LINE.image(CGSize(width: self.view.frame.width, height: 0.2))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveEditButtonPressed(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func initInterfaceComponent() {
        editSegmentCV = editSegmentView.editSegmentCV
        editSegmentCV.register(EditSegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_EDIT_SEGMENT_CELL)
        editSegmentCV.delegate = self
        editSegmentCV.dataSource = self
        
        segmentView = editSegmentView.startSegmentView
        
        timePickerView = editSegmentView.startSegmentView.timePicker
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }
    
    @objc private func cancelButtonPressed(_ sender: Any) {
        if type == .Edit {
            dismiss(animated: true, completion: nil)
        } else {
            title = "Edit Segment Duration"
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            type = .Edit
            segmentView.isHidden = true
        }
    }
    
    @objc private func saveEditButtonPressed(_ sender: Any) {
        switch type {
        case .Start:
            startTimeModel = TimeModel(hours: 0, minutes: minutes, seconds: seconds)
            
        default:
            endTimeModel = TimeModel(hours: 0, minutes: minutes, seconds: seconds)
        }
        title = "Edit Segment Duration"
        type = .Edit
        segmentView.isHidden = true
        checkSaveButtonStatus()
        editSegmentCV.reloadData()
    }
    
    private func checkSaveButtonStatus() {
        if startTimeModel != nil && endTimeModel != nil {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension EditSegmentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_EDIT_SEGMENT_CELL, for: indexPath) as! EditSegmentCell
        
        
        if indexPath.row == 0 {
            cell.segmentLabel.text = "Start Segment"

            guard let startTime = startTimeModel else { return cell }
            if let _ = startTime.hours, let minutes = startTime.minutes, let seconds = startTime.seconds {
                
                var minutesString: String = ""
                var secondsString: String = ""
                
                if minutes < 10 {
                    minutesString = "0\(minutes)"
                } else if minutes >= 10 {
                    minutesString = "\(minutes)"
                }
                if seconds < 10 {
                    secondsString = "0\(seconds)"
                } else if seconds >= 10 {
                    secondsString = "\(seconds)"
                }
                cell.timeSegmentLabel.text = "\(minutesString):\(secondsString)"
            }
        } else {
            cell.segmentLabel.text = "End Segment"
            
            guard let endTime = endTimeModel else { return cell }
            if let _ = endTime.hours, let minutes = endTime.minutes, let seconds = endTime.seconds {
                var minutesString: String = ""
                var secondsString: String = ""
                
                if minutes < 10 {
                    minutesString = "0\(minutes)"
                } else if minutes >= 10 {
                    minutesString = "\(minutes)"
                }
                if seconds < 10 {
                    secondsString = "0\(seconds)"
                } else if seconds >= 10 {
                    secondsString = "\(seconds)"
                }
                cell.timeSegmentLabel.text = "\(minutesString):\(secondsString)"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            title = "Start Segment"
            type = .Start
            self.segmentView.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            title = "End Segment"
            type = .End
            self.segmentView.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeScreen = UIScreen.main.bounds
        
        return CGSize(width: sizeScreen.width, height: 45)
    }
}

extension EditSegmentVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(format: "%02d Minutes", row)
        }
        
        return String(format: "%02d Seconds", row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let minute = row
            print(minute)
            minutes = minute
        }else{
            let second = row
            seconds = second
        }
    }
}
