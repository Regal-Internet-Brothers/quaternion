Strict

Public

' Imports (Private):
Private

Import regal.util.math
Import regal.vector

Public

' Classes:
Class Quaternion Extends Vector4D<Float>
	' Constant variable(s):
	
	' This represents the length of the coordinates (Always starting at zero).
	Const COORDINATES_LENGTH:= Vector3D<Float>.INTERNAL_SIZE
	
	' Constructor(s):
	Method New()
		' Nothing so far.
	End
	
	Method New(S:Float, X:Float, Y:Float, Z:Float)
		Super.New(X, Y, Z, S)
	End
	
	Method New(Q:Quaternion)
		Set(Q)
	End
	
	Method Set:Void(Q:Quaternion)
		Assign(Q)
		
		Return
	End
	
	Method Set:Void(S:Float, X:Float, Y:Float, Z:Float)
		Self.X = X
		Self.Y = Y
		Self.Z = Z
		Self.S = S
		
		Return
	End
	
	Method Set:Void(S:Float, V:Vector3D<Float>)
		Assign(V)
		
		Self.S = S
		
		Return
	End
	
	' Methods:
	Method Conjugate:Void()
		Multiply(-1.0, COORDINATES_LENGTH)
		
		Return
	End
	
	Method Invert:Void()
		Local SumSquared:= Self.SumSquared
		
		Conjugate()
		
		Multiply(1.0 / SumSquared)
		
		Return
	End
	
	' This wrapper-layer may change later:
	Method MultiplyWith:Void(Q_X:Float, Q_Y:Float, Q_Z:Float, Q_S:Float)
		' Hold the current state of this object:
		Local X:= Self.X
		Local Y:= Self.Y
		Local Z:= Self.Z
		Local S:= Self.S
		
		' Calculate the dot-product between this object's original state and the input:
		Local CoordDotProduct:= (X * Q_X) + (Y * Q_Y) + (Z * Q_Z)
		
		' Calculate the cross product from this object's original state and the input:
		Self.X = Y*Q_Z - Z*Q_Y
		Self.Y = Z*Q_X - X*Q_Z
		Self.Z = X*Q_Y - Y*Q_X
		
		' Blend the three object states together:
		Self.X += ((Q_X * S) + X * Q_S)
		Self.Y += ((Q_Y * S) + Y * Q_S)
		Self.Z += ((Q_Z * S) + Z * Q_S)
		
		Self.S = ((S * Q_S) - CoordDotProduct)
		
		Return
	End
	
	Method MultiplyWith:Void(Q:Quaternion)
		MultiplyWith(Q.X, Q.Y, Q.Z, Q.S)
		
		Return
	End
	
	Method MultiplyWith:Void(S:Float)
		MultiplyWith(0.0, 0.0, 0.0, S)
		
		Return
	End
	
	' Methods (Protected):
	Protected
	
	' This is done to attempt to lock 'Multiply' off from the public API, forcing users to work with 'MultiplyWith'.
	' In other words, this is a terrible hack that's necessary because Monkey 1 can't resolve overloads well enough.
	Method Multiply:Void(__PassThrough_A:Float, B:Int=AUTO, C:Int=XPOS)
		Super.Multiply(__PassThrough_A, B, C)
		
		Return
	End
	
	Public
	
	' Properties:
	Method IsNormalized:Bool(Epsilon:Float=0.001, Data_Length:Int=AUTO, Data_Offset:Int=XPOS) Property
		Return FloatsEqual(SumSquared, 1.0, Epsilon)
	End
	
	Method S:Float() Property
		Return W
	End
	
	Method S:Void(Value:Float) Property
		W(Value)
		
		Return
	End
End