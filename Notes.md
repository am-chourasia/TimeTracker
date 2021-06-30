> ### Streams and StreamBuilders
>
> - A stream is like a pipe that contains data. The data entered thourgh one end can be listened by listeners, all getting the same data.
>     - Stream Controller is used to put data into the stream
> - StreamBuilder can listen to exposed stream and return widgets and captures snapshot of recieved stream data.
>
> We are using streams as a state management technique to provide auth variable and its change to all its listeners.
>
>> #### Advantages:
>>
>> - Stateful widgets changed to Stateless widget (landingPage.dart)
>> - No explicits state updates across widgets (no lifting of state required).

<br>  

> ### Navigators And Routes
>
> - Navigator is a  widget that manages a set of child widgets using Stack
> - Routes are basically different "screens" or "pages" in an app, that is managed by Navigator
> - In MaterialApp, it is created automatically and can be refered with `Navigator.of`
>
> - The route defines its widget with a builder function instead of a child widget because it will be built and rebuilt in different contexts depending on when it's pushed and popped.
>
> - Routes can also return a value. Methods that push a route return a Future. The Future resolves when the route is popped and the Future's value is the pop method's result parameter.

<br>

> ### Inherited Widget
> - Any widget below this in the widget tree can reference it.
> - Can be used as a state management technique, as previously used to prevent useless passing down of auth object to widgets down the widget tree.
> - `updateShouldNotify()` method is used to tell flutter if it should redraw the widgets that depend on the data when it changes
> - Provider package is used here to do this automatically with the Auth Object.