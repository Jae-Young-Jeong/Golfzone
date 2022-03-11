
/* made by yjwon88

*/


if(!alertify.myAlert){
	//define a new dialog
	alertify.dialog('myAlert',function factory(){
		return {
			main:function(message, params){ 
				this.message = message; 

				if(params != undefined) {
					this.myParams = params;
					if(params.title != undefined) {
						this.elements.header.innerHTML = params.title;
					} else {
						this.elements.header.innerHTML = "peneo";
					}
				} else {
					this.elements.header.innerHTML = "peneo";
				}
			},
			setup:function(){
				return { 
					buttons:[{text: "Ok", key:13/*Esc*/}],
					focus: { element:0 }
				};
			},
			prepare:function(){
				this.setContent(this.message);
			},
			callback: function(eventCallback) {
				if(this.myParams != undefined && this.myParams.callback != undefined && typeof this.myParams.callback === "function") {
					this.myParams.callback(eventCallback);
				}
			}
		}
	});
}

if(!alertify.myConfirm){
	//define a new dialog
	alertify.dialog('myConfirm',function factory(){
		return {
			myParams: undefined,
			main:function(message, params){ 
				this.message = message; 

				if(params != undefined) {
					this.myParams = params;
					if(params.title != undefined) {
						this.elements.header.innerHTML = params.title;
					} else {
						this.elements.header.innerHTML = "peneo";
					}
				} else {
					this.elements.header.innerHTML = "peneo";
				}
			},
			setup:function(){
				return { 
					buttons:[{text: "No", key:27/*Esc*/}, {text: 'Yes', key: 13}],
					focus: { element:1 }
				};
			},
			prepare:function(){
				this.setContent(this.message);
			},
			callback: function(eventCallback) {
				if(this.myParams != undefined && this.myParams.callback != undefined && typeof this.myParams.callback === "function") {
					this.myParams.callback(eventCallback);
				}
			}
		}
	});
}

