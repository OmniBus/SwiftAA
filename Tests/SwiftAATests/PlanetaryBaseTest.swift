//
//  PlanetaryBaseTest.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
@testable import SwiftAA

class PlanetaryBaseTest: XCTestCase {
    var jd: JulianDay = 0.0

    func testPlanetBasic() {
        XCTAssertEqual(Planet.averageColor, Color.white)
    }
    
    func testMercuryTypes() {
        let mercury = Mercury(julianDay: self.jd)
        XCTAssertEqual(mercury.name, "Mercury")
        XCTAssertEqual(mercury.planet, .Mercury)
        XCTAssertEqual(mercury.planetStrict, .mercury)
        XCTAssertEqual(mercury.planetaryObject, .MERCURY)
    }

    func testVenusTypes() {
        let venus = Venus(julianDay: self.jd)
        XCTAssertEqual(venus.name, "Venus")
        XCTAssertEqual(venus.planet, .Venus)
        XCTAssertEqual(venus.planetStrict, .venus)
        XCTAssertEqual(venus.planetaryObject, .VENUS)
    }

    func testEarthTypes() {
        let earth = Earth(julianDay: self.jd)
        XCTAssertEqual(earth.name, "Earth")
        XCTAssertEqual(earth.planet, .Earth)
        XCTAssertEqual(earth.planetStrict, .earth)
        XCTAssertEqual(earth.planetaryObject, .UNDEFINED) // <-- yes, UNDEFINED.
    }

    func testMarsTypes() {
        let mars = Mars(julianDay: self.jd)
        XCTAssertEqual(mars.name, "Mars")
        XCTAssertEqual(mars.planet, .Mars)
        XCTAssertEqual(mars.planetStrict, .mars)
        XCTAssertEqual(mars.planetaryObject, .MARS)
    }

    func testJupiterTypes() {
        let jupiter = Jupiter(julianDay: self.jd)
        XCTAssertEqual(jupiter.name, "Jupiter")
        XCTAssertEqual(jupiter.planet, .Jupiter)
        XCTAssertEqual(jupiter.planetStrict, .jupiter)
        XCTAssertEqual(jupiter.planetaryObject, .JUPITER)
    }

    func testSaturnTypes() {
        let saturn = Saturn(julianDay: self.jd)
        XCTAssertEqual(saturn.name, "Saturn")
        XCTAssertEqual(saturn.planet, .Saturn)
        XCTAssertEqual(saturn.planetStrict, .saturn)
        XCTAssertEqual(saturn.planetaryObject, .SATURN)
    }

    func testUranusTypes() {
        let uranus = Uranus(julianDay: self.jd)
        XCTAssertEqual(uranus.name, "Uranus")
        XCTAssertEqual(uranus.planet, .Uranus)
        XCTAssertEqual(uranus.planetStrict, .uranus)
        XCTAssertEqual(uranus.planetaryObject, .URANUS)
    }

    func testNeptuneTypes() {
        let neptune = Neptune(julianDay: self.jd)
        XCTAssertEqual(neptune.name, "Neptune")
        XCTAssertEqual(neptune.planet, .Neptune)
        XCTAssertEqual(neptune.planetStrict, .neptune)
        XCTAssertEqual(neptune.planetaryObject, .NEPTUNE)
    }

    func testPlutoTypes() {
        let pluto = Pluto(julianDay: self.jd)
        XCTAssertEqual(pluto.name, "Pluto")
        XCTAssertEqual(pluto.planet, .Pluto)
        XCTAssertEqual(pluto.planetStrict, .undefined) // <-- yes, undefined.
        XCTAssertEqual(pluto.planetaryObject, .UNDEFINED) // <-- yes, UNDEFINED.
    }
    
    // See AA, p.270, Example 38.a
    func testPerihelionAphelion() {
        let venus = Venus(julianDay: JulianDay(year: 1978, month: 10, day: 15))
        AssertEqual(venus.perihelion, JulianDay(2443873.704), accuracy: JulianDay(0.001))
    }
    
    // See AA, p.270, Example 38.b
    func testAphelion() {
        let mars = Mars(julianDay: JulianDay(year: 2032, month: 1, day: 1))
        AssertEqual(mars.aphelion, JulianDay(2463530.456), accuracy: JulianDay(0.001))
    }

}
