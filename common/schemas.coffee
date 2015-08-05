
Schemas = {}

Schemas.Chat = new SimpleSchema
    text:
        type: String
        label: "text"
        max: 25
        optional: false
    createdAt:
        type: Date
        label: "Create Date"
        denyUpdate: true
        optional: false
        autoValue: ->
            if (this.isInsert)
                return new Date
            else
              if (this.isUpsert)
                return {$setOnInsert: new Date}
              else
                this.unset()


###Schemas.Cards = new SimpleSchema
    text:
        type: String
        label: "text"
        max: 25
        optional: false
    createdAt:
        type: Date
        label: "Create Date"
        denyUpdate: true
        optional: false
        autoValue: ->
            if (this.isInsert)
                return new Date
            else
              if (this.isUpsert)
                return {$setOnInsert: new Date}
              else
                this.unset()                
###


Chat.attachSchema Schemas.Chat
###Cards.attachSchema Schemas.Cards###