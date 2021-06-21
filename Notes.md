> ### Streams and StreamBuilders
>
> - A stream is like a pipe that contains data. The data entered thourgh one end can be listened by listeners, all getting the same data.
>     - Stream Controller is used to put data into the stream
> - StreamBuilder can listen to exposed stream and return widgets and captures snapshot of recieved stream data.
>
> We are using streams as a state management technique to provide auth variable and its change to all its listeners.
>
>> #### `Advantages:`
>>
>> - Stateful widgets changed to Stateless widget (landingPage.dart)
>> - No explicits state updates across widgets (no lifting of state required).
