Strict

Public

' Imports:
Import regal.quaternion
Import regal.vector

' Functions:
Function Main:Int()
	'DebugStop()
	
	' Normalized axis.
	Local a:= New Vector3D<Float>(0.0, 1.0, 0.0)
	
	' Angle.
	Local angle:= 0.1
	
	' Half the angle.
	Local hAngle:= angle/2.0
	
	' Allocate a point to rotate.
	Local point:= New Vector3D<Float>(35.0, -28.3, 5.9)
	
	' Main Quaternion.
	Local q:= New Quaternion()
	
	q.S = Cosr(hAngle)
	
	a.Multiply(Sinr(hAngle))
	
	q.X = a.X
	q.Y = a.Y
	q.Z = a.Z
	
	
	
	' Create Quaternion of the point to rotate:
	Local p:= New Quaternion()
	Local qtmp:= New Quaternion()
	
	p.Set(0.0, point)
	
	qtmp.Set(q)
	
	Local res:= New Quaternion()
	Local inverseQ:= New Quaternion()
	
	
	inverseQ.Set(qtmp)
	inverseQ.Invert()
	
	res.Set(qtmp)
	res.MultiplyWith(p)
	
	res.MultiplyWith(inverseQ)
	
	point.X = res.X
	point.Y = res.Y
	point.Z = res.Z
	
	Print("Result: " + point)
	
	Return 0
End