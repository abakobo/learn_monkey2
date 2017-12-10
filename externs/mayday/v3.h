#ifndef V3_H
#define V3_H


struct sVect2
{
	float		x, y;
	float  arros[5];
    //
	sVect2() = default;
    //
	sVect2(float a, float b)
	{
		x = a;
		y = b;
		arros[0]=9;
		arros[1]=10;
		arros[2]=11;
		arros[3]=12;
		arros[4]=13;
	}
    //
	float aroule(float a[2])
	{
	return a[0]+a[1];
	}
template<typename T>
void MSwap(T& a, T& b)
	{
	T tmp = a;
	a = b;
	b = tmp;
	}
	
};
//
template<typename T>
 void FSwap(T& a, T& b)
	{
	T tmp = a;
	a = b;
	b = tmp;
	}
	
#endif
