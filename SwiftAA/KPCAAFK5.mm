//
//  KPCAAFK5.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAFK5.h"
#import "AAFK5.h"


double KPCAAFK5CorrectionInLongitude(double Longitude, double Latitude, double JD)
{
    return CAAFK5::CorrectionInLongitude(Longitude, Latitude, JD);
}

double KPCAAFK5CorrectionInLatitude(double Longitude, double JD)
{
    return CAAFK5::CorrectionInLatitude(Longitude, JD);
}

KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5J2000(KPCAA3DCoordinateComponents components)
{
    CAA3DCoordinate coordsIn = CAA3DCoordinate();
    coordsIn.X = components.X;
    coordsIn.Y = components.Y;
    coordsIn.Z = components.Z;
    
    CAA3DCoordinate coordsOut = CAAFK5::ConvertVSOPToFK5J2000(coordsIn);
    return KPCAA3DCoordinateComponentsMake(coordsOut.X, coordsOut.Y, coordsOut.Z);
}

KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5B1950(KPCAA3DCoordinateComponents components)
{
    CAA3DCoordinate coordsIn = CAA3DCoordinate();
    coordsIn.X = components.X;
    coordsIn.Y = components.Y;
    coordsIn.Z = components.Z;
    
    CAA3DCoordinate coordsOut = CAAFK5::ConvertVSOPToFK5B1950(coordsIn);
    return KPCAA3DCoordinateComponentsMake(coordsOut.X, coordsOut.Y, coordsOut.Z);
}

KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5AnyEquinox(KPCAA3DCoordinateComponents components, double JDEquinox)
{
    CAA3DCoordinate coordsIn = CAA3DCoordinate();
    coordsIn.X = components.X;
    coordsIn.Y = components.Y;
    coordsIn.Z = components.Z;
    
    CAA3DCoordinate coordsOut = CAAFK5::ConvertVSOPToFK5AnyEquinox(coordsIn, JDEquinox);
    return KPCAA3DCoordinateComponentsMake(coordsOut.X, coordsOut.Y, coordsOut.Z);
}

