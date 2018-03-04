#include "date.h"
 
// Date constructor
Date::Date(int year, int month, int day)
{
    SetDate(year, month, day);
}
Date::Date()
{
	SetDate(1985, 1, 1);
}

Date::~Date()
{
	// nothing to do in this simple example
}
 
// Date member function
void Date::SetDate(int year, int month, int day)
{
    m_month = month;
    m_day = day;
    m_year = year;
}