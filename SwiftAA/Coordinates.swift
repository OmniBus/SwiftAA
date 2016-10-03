//
//  Coordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct GeographicCoordinates {
    fileprivate(set) var longitude: Degree
    fileprivate(set) var latitude: Degree
    var altitude: Meter
    
    init(positivelyWestwardLongitude longitude: Degree, latitude: Degree, altitude: Meter = 0) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    
    
    /// High accuracy computation of the distance between two points on Earth's surface, taking into account
    /// the Earth flattening.
    ///
    /// - parameter otherCoordinates: The coordinates of the second point.
    ///
    /// - returns: The distance, in meters, between the two points, along Earth's surface.
    public func globeDistance(to otherCoordinates: GeographicCoordinates) -> Meter {
        // KPCAA result is in kilometers.
        return KPCAAGlobe_DistanceBetweenPoints(self.latitude,
                                                self.longitude,
                                                otherCoordinates.latitude,
                                                otherCoordinates.longitude) * 1000
    }
}

public struct EquatorialCoordinates {
    fileprivate(set) var rightAscension: Hour
    fileprivate(set) var declination: Degree
    public let epoch: Double
    
    var alpha: Hour {
        get { return self.rightAscension }
        set { self.rightAscension = newValue }
    }
    
    var delta: Degree {
        get { return self.declination }
        set { self.declination = newValue }
    }
    
    init(alpha: Hour, delta: Degree, epsilon: Double) {
        self.rightAscension = alpha
        self.declination = delta
        self.epoch = epsilon
    }
    
    func toEclipticCoordinates() -> EclipticCoordinates {
        let components = KPCAACoordinateTransformation_Equatorial2Ecliptic(self.rightAscension, self.declination, self.epoch)
        return EclipticCoordinates(lambda: components.X, beta: components.Y, epsilon: self.epoch)
    }
    
    /**
     Transform the coordinates to galactic ones.
     
     The galactic coordinates system has been defined by the International Astronomical Union 
     in 1959. In the standard equatorial system of B1950.0, the galactic North Pole
     has the coordinates: alpha = 192.25 Degree, and delta = 27.4 Degree, and the origin
     of the galactic longitude is the point (in western Sagittarius) of the galactic equator 
     which is 33º distant from the ascending node (in western Aquila) of the galactic equator
     with the equator of B1950.0.
     These values have been fixed conventionally and therefore must be considered as exact for 
     the mentionned equinox of B1950.0
     
     - returns: The corresponding galactic coordinates.
     */
    func toGalacticCoordinates() -> GalacticCoordinates {
        let precessedCoords = self.precessedCoordinates(to: StandardEpoch_B1950_0)
        let components = KPCAACoordinateTransformation_Equatorial2Galactic(precessedCoords.rightAscension, precessedCoords.declination)
        return GalacticCoordinates(l: components.X, b: components.Y)
    }
    
    func toHorizontalCoordinates(forGeographicalCoordinates coords: GeographicCoordinates, julianDay: JulianDay) -> HorizontalCoordinates {
        let lha = julianDay.meanLocalSiderealTime(forGeographicLongitude: coords.longitude)
        let components = KPCAACoordinateTransformation_Equatorial2Horizontal(lha, self.declination, coords.latitude)
        return HorizontalCoordinates(azimuth: components.X, altitude: components.Y, geographicCoordinates: coords, julianDay: julianDay, epoch: self.epoch)
    }
    
    func precessedCoordinates(to newEpoch: Double) -> EquatorialCoordinates {
        let components = KPCAAPrecession_PrecessEquatorial(self.rightAscension, self.declination, self.epoch, newEpoch)
        return EquatorialCoordinates(alpha: components.X, delta: components.Y, epsilon: newEpoch)
    }
    
    func angularSeparation(from otherCoordinates: EquatorialCoordinates) -> Degree {
        return KPCAAAngularSeparation_Separation(self.alpha, self.delta, otherCoordinates.alpha, otherCoordinates.delta)
    }
    
    func positionAngle(with otherCoordinates: EquatorialCoordinates) -> Degree {
        return KPCAAAngularSeparation_PositionAngle(self.alpha, self.delta, otherCoordinates.alpha, otherCoordinates.delta)
    }
}

public struct EclipticCoordinates {
    fileprivate(set) var celestialLongitude: Degree
    fileprivate(set) var celestialLatitude: Degree
    public let epoch: Double
    
    var lambda: Degree {
        get { return self.celestialLongitude }
        set { self.celestialLongitude = newValue }
    }
    
    var beta: Degree {
        get { return self.celestialLatitude }
        set { self.celestialLatitude = newValue }
    }
    
    init(lambda: Degree, beta: Degree, epsilon: Double) {
        self.celestialLongitude = lambda
        self.celestialLatitude = beta
        self.epoch = epsilon
    }
    
    func toEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude, self.celestialLatitude, self.epoch)
        return EquatorialCoordinates(alpha: components.X, delta: components.Y, epsilon: self.epoch)
    }
    
    func precessedCoordinates(to newEpoch: Double) -> EclipticCoordinates {
        let components = KPCAAPrecession_PrecessEcliptic(self.celestialLongitude, self.celestialLatitude, self.epoch, newEpoch)
        return EclipticCoordinates(lambda: components.X, beta: components.Y, epsilon: newEpoch)
    }
}

public struct GalacticCoordinates {
    fileprivate(set) var galacticLongitude: Degree
    fileprivate(set) var galacticLatitude: Degree
    public let epoch: Double = StandardEpoch_B1950_0

    var l: Degree {
        get { return self.galacticLongitude }
        set { self.galacticLongitude = newValue }
    }
    
    var b: Degree {
        get { return self.galacticLatitude }
        set { self.galacticLatitude = newValue }
    }

    init(l: Degree, b: Degree) {
        self.galacticLongitude = l
        self.galacticLatitude = b
    }
    
    /**
     Transform the coordinates to equatorial ones.
     Careful: the epoch is necessarily that of the galactic coordinates which is always B1950.0.
     
     - returns: The corresponding equatorial coordinates.
     */
    func toEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Galactic2Equatorial(self.galacticLongitude, self.galacticLatitude)
        return EquatorialCoordinates(alpha: components.X, delta: components.Y, epsilon: self.epoch)
    }
}

public struct HorizontalCoordinates {
    fileprivate(set) var azimuth: Degree // westward from the South see AA. p91
    fileprivate(set) var altitude: Degree
    fileprivate(set) var geographicCoordinates: GeographicCoordinates
    fileprivate(set) var julianDay: JulianDay
    fileprivate(set) var epoch: Double
    
    init(azimuth: Degree, altitude: Degree, geographicCoordinates: GeographicCoordinates, julianDay: JulianDay, epoch: Double) {
        self.azimuth = azimuth
        self.altitude = altitude
        self.geographicCoordinates = geographicCoordinates
        self.julianDay = julianDay
        self.epoch = epoch
    }
    
    func toEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Horizontal2Equatorial(self.azimuth, self.altitude, self.geographicCoordinates.latitude)
        return EquatorialCoordinates(alpha: components.X, delta: components.Y, epsilon: self.epoch)
    }

}
