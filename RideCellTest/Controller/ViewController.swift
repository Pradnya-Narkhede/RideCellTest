//
//  ViewController.swift
//  RideCellTest
//
//  Created by Apple on 16/07/22.
//

import UIKit
import MapKit
import CoreLocation
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var mapRecenterIcon: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    var carInfo = [carModel]()
    var locationManager = CLLocationManager()
    var pointAnnotation: MKPointAnnotation?
    var pinAnnotationView: CustomMapPinView?
    var annotations = [MKAnnotation]()
    var viewModel : VehicleProtocol?
    
    //MARK: - ViewLife Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getLocationData()
        setPinUsingMKPointAnnotation()
    }
    
    //MARK: Functional Methods
    func setUpUI(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //Cell Register
        collectionView.register(UINib(nibName: "VehicleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VehicleCollectionViewCell")
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
    }
    
    func getLocationData(){
        viewModel = VehicleViewModel()
        if let localData = viewModel?.readLocalFile(forName: "vehicles"){
            viewModel?.parse(jsonData: localData, completion: { data in
                for i in data{
                    let carObj = carModel(id: i.id ?? 0, lat: i.lat ?? 0.0,lng: i.lng ?? 0.0, carImg: i.vehiclePicAbsoluteURL ?? "", vehicleTypes: i.vehicleType ?? "", remainingMilege: i.remainingMileage ?? 0, remainingRangeInMeters: i.remainingRangeInMeters ?? 0, licensePlateNumber: i.licensePlateNumber ?? "")
                    self.carInfo.append(carObj)
                }
            })
        }
    }
    
    func setPinUsingMKPointAnnotation(){
        
        for location in carInfo{
            pointAnnotation = MKPointAnnotation()
            pointAnnotation?.coordinate = CLLocationCoordinate2D(latitude: location.lat,longitude: location.lng)
            pointAnnotation?.title = "\(location.licensePlateNumber)"
            pointAnnotation?.subtitle = "\(location.vehicleTypes),\(location.id),\(location.remainingRangeInMeters)"
            
            annotations.append(pointAnnotation!)
        }
        
        let coordinateRegion = MKCoordinateRegion(center: annotations[0].coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotations(annotations)
        
    }
    
    //MARK: - IBAction Methods
    @IBAction func mapRecenterIconButtonClick(_ sender: Any) {
        print("Recenter Location")
    }
}

//MARK: CollectionView Delegate Datasource Methods
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCollectionViewCell", for: indexPath) as! VehicleCollectionViewCell
        cell.vehicleName.text = carInfo[indexPath.row].vehicleTypes
        cell.vehicleImageView.sd_setImage(with: URL(string: carInfo[indexPath.row].carImg), placeholderImage: UIImage(named: "carDefaultImage"))
        cell.remainingMilege.text = "\(carInfo[indexPath.row].remainingMilege) $/min"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinateRegion = MKCoordinateRegion(center: annotations[indexPath.row].coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
}

//MARK: MapView Delegate Methods
extension ViewController:MKMapViewDelegate,  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12))
        mapView.setRegion(mRegion, animated: true)
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        //let customPointAnnotation = annotation as! CustomPointAnnotation
        let scaleTransform = CGAffineTransform(scaleX: 0.0, y: 0.0)  // Scale
        UIView.animate(withDuration: 2, animations: {
            annotationView.transform = scaleTransform
            annotationView.layoutIfNeeded()
        }) { (isCompleted) in
            
            // Nested block of animation
            UIView.animate(withDuration: 2, animations: {
                annotationView.alpha = 1.0
                annotationView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                annotationView.layoutIfNeeded()
            })
        }
        pinAnnotationView = UIView.fromNib()
        pinAnnotationView?.isHidden = false
        
        pinAnnotationView?.frame = CGRect(x: -15, y: -15, width: 60, height: 60)
        pinAnnotationView?.annotationImage.sd_setImage(with: URL(string: carInfo[0].carImg), placeholderImage: UIImage(named: "carDefaultImage"))
        annotationView.canShowCallout = true
        annotationView.addSubview(pinAnnotationView!)
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Annotation Pressed")
    }
}
