# Plivo for GMS2
A basic function library to use Plivo call and text integration with GameMaker Studio 2

## Prerequisites

- An active account on plivo.com with a balance and at least one associated number.
- GameMaker Studio 2 ( yoyogames.com )

## How To Use
Currently there are only four components to this library: Initialization, Texting, Calling, and Debugging.

You MUST initialize before attempting to use Calling or Texting functionality. You only need to call the initialize function once, and it returns a global variable - so you can call it from anywhere in your project.

Ideally you'd call this in a Create event of an object that appears at the beginning of your project.

```GML
plivo_init([YOUR PLIVO AUTH ID], [YOUR PLIVO AUTH TOKEN]);
```

## Sending an SMS Message
Sending an SMS is the most straight forward functionality - you supply the function with one of your Plivo numbers, the number you're attempting to message, and the message.

```GML
plivo_text([YOUR PLIVO NUMBER],[THE NUMBER TO SEND TO],[THE MESSAGE]);
```

In practice, this would look something like this:
```GML
plivo_text("+15559998888","+18885559999","Hello world! This is GMS2 + Plivo <3");
```

** Please Note **
The numbers aren't formatted by this library at all, so you'll have to do that seperately to maintain compatibility with the expectations of the Plivo API. This means all numbers going into the functions should be 12 characters long, including the + sign before them.

## Placing a Call
This function points towards an XML file on the internet to make decisions for the call. The Plivo documentation shows you how to structure your XML file for these situations, but we'll use their example as the example here (which generates a text-to-speech message upon pickup)

```GML
plivo_call([YOUR PLIVO NUMBER],[THE NUMBER TO CALL],[THE URL FOR THE XML FILE]);
```

In practice, this would look something like this:
```GML
plivo_call("+15559998888","+18885559999","https://s3.amazonaws.com/static.plivo.com/answer.xml");
```

## Debugging
If you need to see the response of the Plivo API, all you need to do is ask!

In the Async - HTTP event of the object making a request (plivo_call or plivo_text), add this code:

```GML
plivo_debug();
```

Once a response has been recieved from a valid or invalid request to the Plivo API, a message containing the response will appear on your screen.
