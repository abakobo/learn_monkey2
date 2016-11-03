#ifndef DATE_H
#define DATE_H
 
class Date
{
private:
    int m_year;
    int m_month;
    int m_day;
 
public:
    Date(int year, int month, int day);
	
	Date();

    ~Date(); // destructor
 
    void SetDate(int year, int month, int day);
 
    int getYear() { return m_year; }
    int getMonth() { return m_month; }
    int getDay()  { return m_day; }
	
	int foo;
};

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
    int m_year=7777;
}
 
// Date member function
void Date::SetDate(int year, int month, int day)
{
    m_month = month;
    m_day = day;
    m_year = year;
}

#endif