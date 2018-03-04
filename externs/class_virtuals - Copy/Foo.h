#ifndef FOO_H
#define FOO_H
 
 
class b2QueryCallback
{
public:
	virtual ~b2QueryCallback() {}

	/// Called for each fixture found in the query AABB.
	/// @return false to terminate the query.
	virtual bool ReportFixture(int fixture) = 0;
}; 
 
/*
class Foo
{

public:
	int foo;
    int getFoo()  { return foo; }

    virtual void MyVirtualMethod(int i) = 0;
};
 */
#endif
