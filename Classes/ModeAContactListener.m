//
//  ModeAContactListener.m
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "ModeAContactListener.h"


ModeAContactListener::ModeAContactListener() : _contacts() {
}

ModeAContactListener::~ModeAContactListener() {
}

void ModeAContactListener::BeginContact(b2Contact* contact) {
    // We need to copy out the data because the b2Contact passed in
    // is reused.
    //MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    //_contacts.push_back(myContact);
}

void ModeAContactListener::EndContact(b2Contact* contact) {
	/*
	 MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
	 std::vector<MyContact>::iterator pos;
	 pos = std::find(_contacts.begin(), _contacts.end(), myContact);
	 if (pos != _contacts.end()) {
	 _contacts.erase(pos);
	 }
	 */
}

void ModeAContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold) {
	
}

void ModeAContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) {
	
	// find the strength of the impulse..
	int32 count = contact->GetManifold()->pointCount;
	float32 maxImpulse = 0.0f;
	for (int32 i = 0; i < count; ++i) {
		maxImpulse = b2Max(maxImpulse, impulse->normalImpulses[i]);
	}
	//NSLog(@"maxImpulse: %f", maxImpulse);
	
	if (maxImpulse > 1.0f) {
		
		MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB(), maxImpulse };
		_contacts.push_back(myContact);
				
	}

}