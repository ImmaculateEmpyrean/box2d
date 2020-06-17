#include<iostream>
#include<vector>
#include<string>

#include "box2d/box2d.h"

int main()
{
	b2Vec2 Gravity(0.0f, -10.0f);

	b2World Universum(Gravity);

	b2BodyDef GroundBodyDefinition;
	GroundBodyDefinition.position.Set(0.0f, -20.0f);

	b2Body* GroundBody = Universum.CreateBody(&GroundBodyDefinition);

	b2PolygonShape GroundShape;
	GroundShape.SetAsBox(50.0f, 10.0f);

	GroundBody->CreateFixture(&GroundShape, 0.0f);

	b2BodyDef CubeBodyDefinition;
	CubeBodyDefinition.position.Set(0.0f, 10.0f);
	CubeBodyDefinition.type = b2_dynamicBody;

	b2Body* CubeBody = Universum.CreateBody(&CubeBodyDefinition);

	b2PolygonShape BoxShape;
	BoxShape.SetAsBox(10.f, 5.0f);

	b2FixtureDef CubeBodyFixtureDefinition;
	CubeBodyFixtureDefinition.shape = &BoxShape;
	CubeBodyFixtureDefinition.density = 1.0f;
	CubeBodyFixtureDefinition.friction = 0.3f;

	CubeBody->CreateFixture(&CubeBodyFixtureDefinition);

	float timestep = 1.0f / 60.0f;
	int32 velocityiterations = 6;
	int32 positionIterations = 2;

	b2Vec2 Position = CubeBody->GetPosition();
	float angle = CubeBody->GetAngle();
	std::cout << "Position : [" << Position.x << "," << Position.y << "]" << " Angle : " << angle <<" I : "<<"-1"<< std::endl;

	for (int i = 0; ;i++)//Position.y>=1.0f;i++)
	{
		Universum.Step(timestep, velocityiterations, positionIterations);

		Position = CubeBody->GetPosition();
		angle = CubeBody->GetAngle();

		std::cout << "Position : [" << Position.x << "," << Position.y << "]" << " Angle : " << angle << " I : " << i << std::endl;
	}


}