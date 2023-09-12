;(function () {
    var REQUIRED_CELL_CLASS = "requiredCell";
    var DEFAULT_REQUIRED_MESSAGE = "Required";
    BatchExtensions = {};
        
    // == RelatedComboBoxes Manager ==
    // ------------------------
    var Relation = function (name, relatedTo) {
    	this.name = name;
    	this.relatedTo = relatedTo;
    	this.toRelate = [];
    	this.tempValue;
    	this.tempRelatedValue;
    };
    
    BatchExtensions.RelatedComboBoxesManager = function (data) {
    	var setComboValue = true;;
    	var relations = [];
    	var batchManager;
    	var tableView;
    	var manualValueChange;
    	var comboBox;
    	var currentItem;
    	var currentTarget;
    	var currentCellValue;

    	return {
    		init: function (data) {
    			var that = this;
    			
    			if (data.grid && data.toolTipID) {
    				that.grid = data.grid;
    				batchManager = that.grid.get_batchEditingManager();
    				tableView = that.grid.get_masterTableView();
    				
    				that.grid.add_rowClick(function (sender, args) {
    					that._handleGridRowClick(sender, args);
    				});

    				that.grid.add_batchEditOpening(function (sender, args) {
    					that._handleBatchEditOpening(sender, args);
    				});

    				that.grid.add_batchEditCellValueChanged(function (sender, args) {
    					that._handleBatchEditCellValueChanged(sender, args);
    				});

    				that.grid.add_rowCreated(function (sender, args) {
    					that._handleGridRowCreated(sender, args);
    				});

    				setTimeout(function () {
    					that.toolTip = $find(data.toolTipID);
    					comboBox = $find(that.toolTip.get_element().children[0].id);
    					that.messageToolTip = $find(that.toolTip.get_element().children[1].id);
    					comboBox.get_dropDownElement().parentElement.style.zIndex = 12000;
    					that.toolTip.add_show(function (sender, args) {
    						that._handleToolTipShow(sender, args);
    					});

    					comboBox.add_selectedIndexChanged(function (sender, args) {
    						that._handleComboSelectedIndexChanged(sender, args);
    					});
    					comboBox.add_itemsRequesting(function (sender, args) {
    						that._handleComboItemsRequesting(sender, args);
    					});

    				    //handling TABKEY
    					comboBox.get_element().onkeydown = function (ev) {
    					    var keyCode = ev.keyCode || ev.charCode;
    					    var findPreviousCell = ev.shiftKey || keyCode === 37;
    					    preventEvent(ev);
    					    var grid = that.grid;
    					    var currentCell = currentItem.get_cell(that.activeColumn);
    					    setTimeout(function () {
    					        that.grid.get_batchEditingManager()._handleTabAction(grid.get_masterTableView(), currentCell, findPreviousCell);
    					    })
    					}

    					comboBox.add_onClientBlur(function (sender, args) {
    						that._handleComboBlur(sender, args);
    					});

    					var toolTipContainer = $(that.toolTip.get_element()).detach();
    					if (!that.grid.GridDataDiv) {
    						$(that.grid.get_element()).append(toolTipContainer);
    					}
    					else {
    						that.grid.GridDataDiv.style.position = "relative";
    						$(that.grid.GridDataDiv).append(toolTipContainer);
    					}
    					
    				});
    			}

    			if (data.relations) {
    				for (var i = 0; i < data.relations.length; i++) {
    					this.add_relation(data.relations[i]);
    				}
    			}

    			return that;
    		},

            add_relation: function (data) {
                relations.push(new Relation(data.columnName, data.relatedTo));
                this._updateRelations();
            },

            _isComboColumn: function (columnName) {
                for (var i = 0; i < relations.length; i++) {
                    if (relations[i].name == columnName) {
                        return true;
                    }
                }

                return false;
            },

            _getRelation: function (columnName) {
                for (var i = 0; i < relations.length; i++) {
                    if (relations[i].name == columnName) {
                        return relations[i];
                    }
                }
            },

            _updateRelations: function () {
                for (var i = 0; i < relations.length; i++) {
                    if (relations[i].relatedTo) {
                        var existingRelation = this._getRelation(relations[i].relatedTo);
                        if (existingRelation) {
                            if (existingRelation.toRelate.indexOf(relations[i].name) < 0) {
                                existingRelation.toRelate.push(relations[i].name);
                            }
                        }
                    }
                }
            },

            //RadToolTip Handlers

            _handleToolTipShow: function (sender, args) {
                if (setComboValue) {
                    if (currentCellValue == "&nbsp;" || currentTarget.className.indexOf(REQUIRED_CELL_CLASS) >= 0) {
                        currentCellValue = "";
                    }
                    comboBox.set_text(currentCellValue);
                }
                else {
                    comboBox.set_text("");
                }

                setComboValue = true;
                comboBox.clearItems();
                comboBox.showDropDown();
            },


            //RadComboBox Handlers

            _handleComboBlur: function (sender, args) {
                this.toolTip.hide();
            },

            _handleComboSelectedIndexChanged: function (sender, args) {
                manualValueChange = true;
                var cell = currentItem.get_cell(this.activeColumn);
                batchManager.changeCellValue(cell, args.get_item().get_text());
                this.toolTip.hide();
            },

            _handleComboItemsRequesting: function (sender, args) {
                var context = args.get_context();
                context["ColumnName"] = this.activeColumn;
                context["RelatedValue"] = this._getRelation(this.activeColumn).tempRelatedValue;
            },


            //RadGrid Handlers

            _handleGridRowClick: function (sender, args) {
                var target = args.get_domEvent().target || args.get_domEvent().srcElement;
                if (target.tagName != "TD") {
                    target = Telerik.Web.UI.Grid.GetFirstParentByTagName(target, "TD");
                }
                currentTarget = target;
                currentItem = args.get_gridDataItem();
            },

            _handleBatchEditOpening: function (sender, args) {
                var that = this;
                var columnName = args.get_columnUniqueName();
                that.activeColumn = columnName;
                if (!manualValueChange && that._isComboColumn(columnName)) {
                    var relation = that._getRelation(columnName);
                    args.set_cancel(true);

                    that.toolTip.set_targetControl(args.get_cell());
                    that.toolTip.set_width(args.get_cell().offsetWidth);
                    currentCellValue = args.get_cell().children[0].innerHTML.trim();
                    var relatedCell = tableView._getCellByColumnUniqueNameFromTableRowElement(args.get_row(), relation.relatedTo);
                    relation.tempRelatedValue = batchManager.getCellValue(relatedCell);
                    var allowShowing = !relatedCell;
                    if (relatedCell && relatedCell.className.indexOf(REQUIRED_CELL_CLASS) < 0) {
                        allowShowing = true;
                    }

                    if (relation.tempRelatedValue != "" && allowShowing) {
                        setTimeout(function () {
                            that.toolTip.show();
                        }, 20);
                    }
                    else if (that.messageToolTip) {
                        that.messageToolTip.set_targetControl(args.get_cell());
                        that.messageToolTip.set_content("<strong>\"" + relation.relatedTo + "\"</strong> should be selected!");
                        setTimeout(function () {
                            that.messageToolTip.show();
                        }, 20);
                    }
                }

                currentItem = args.get_row().control;
                manualValueChange = false;
            },

            _handleBatchEditCellValueChanged: function (sender, args) {
                var that = this;
                var relation = that._getRelation(args.get_columnUniqueName());
                if (relation) {
                    if (relation.toRelate) {
                        setTimeout(function () {
                            for (var i = 0; i < relation.toRelate.length; i++) {
                                var cell = tableView._getCellByColumnUniqueNameFromTableRowElement(args.get_row(), relation.toRelate[i]);
                                currentTarget = cell;
                                manualValueChange = true;
                                batchManager.changeCellValue(cell, "");
                            }                            
                        });
                    }
                }
            },

            _handleGridRowCreated: function (sender, args) {
                if (args.get_itemIndexHierarchical() < 0) {
                    var dataItem = args.get_gridDataItem();
                    currentItem = dataItem;
                }
            }
        }
    };


    // == Validation Manager ==
    // ------------------------
    var Validator = function (columnName, errorMessage, toolTipMessage, validationFunction) {
    	this.columnName = columnName;
    	this.validationFunction = validationFunction || function (value) { return (value != "" && value != "&nbsp;") };
    	if (errorMessage == "") {
    		errorMessage = "&nbsp;";
    	}

    	this.errorMessage = errorMessage || DEFAULT_REQUIRED_MESSAGE;
    	this.toolTipMessage = toolTipMessage || "";
    };

    BatchExtensions.ValidationManager = function () {
    	var validators;
    	var tableView;
    	var batchManager;
    	var elementsToDisable;
    	var requiredFields;

    	return {
    		init: function (data) {
    			var that = this;
    			that.grid = data.grid;
    			batchManager = that.grid.get_batchEditingManager();
    			tableView = that.grid.get_masterTableView();
    			requiredFields = 0;
    			validators = [];

    			that.grid.add_batchEditCellValueChanged(function (sender, args) {
    				that._handleBatchEditCellValueChanged(sender, args);
    			});

    			that.grid.add_rowCreated(function (sender, args) {
    				that._handleGridRowCreated(sender, args);
    			});

    			that.grid.add_command(function (sender, args) {
    				that._handleGridCommand(sender, args);
    			});

    			that.grid.add_batchEditGetCellValue(function (sender, args) {
    				that._handleBatchEditGetCellValue(sender, args);
    			});

    			elementsToDisable = [];
    			elementsToDisable.push($telerik.findElement(that.grid.get_element(), "SaveChangesIcon"));
    			elementsToDisable.push($telerik.findElement(that.grid.get_element(), "SaveChangesButton"));

    			if (data.validators) {
    				for (var i = 0; i < data.validators.length; i++) {
    					that.add_validator(data.validators[i]);
    				}
    			}

    			return that;
    		},

    		add_validator: function (data) {
    			validators.push(new Validator(data.columnName, data.errorMessage, data.toolTipMessage, data.validationFunction));
    		},

    		get_validator: function (columnName) {
    			for (var i = 0; i < validators.length; i++) {
    				if (validators[i].columnName == columnName) {
    					return validators[i];
    				}
    			}
    		},

    		isValid: function () {
    			return requiredFields == 0;
    		},

    		add_elementToDisable: function (element) {
    			elementsToDisable.push(element);
    		},

    		_handleBatchEditCellValueChanged: function (sender, args) {
    			var that = this;
    			var validator = that.get_validator(args.get_columnUniqueName());
    			if (validator) {
    				if (!validator.validationFunction(args.get_editorValue())) {
    					that._setRequiredCell(args.get_cell(), validator);
    				}
    				else {
    					this._removeRequiredClassName(args.get_cell(), REQUIRED_CELL_CLASS);
    				}
    			}

    		},

    		_handleGridRowCreated: function (sender, args) {
    			if (args.get_itemIndexHierarchical() < 0) {
    				var dataItem = args.get_gridDataItem();
    				this._styleRequiredCells(dataItem);
    			}
    		},

    		_handleBatchEditGetCellValue: function (sender, args) {
    			if (args.get_cell().className.indexOf(REQUIRED_CELL_CLASS) >= 0) {
    				args.set_cancel(true);
    				args.set_value("");
    			}
    		},

    		_styleRequiredCells: function (dataItem) {
    			for (var i = 0; i < validators.length; i++) {
    				var cell = dataItem.get_cell(validators[i].columnName);
    				this._setRequiredCell(cell, validators[i]);
    			}
    		},

    		_setRequiredCell: function (element, validator) {
    			if (element) {
    				if (element.className.indexOf(REQUIRED_CELL_CLASS) < 0) {
    					addClassName(element, REQUIRED_CELL_CLASS);
    					requiredFields++;
    				}

    				element.children[0].innerHTML = validator.errorMessage;
    				element.children[0].title = validator.toolTipMessage;
    				if (requiredFields == 1) {
    					this._setDisabledStateForGridButtons();
    				}
    			}
    		},

    		_removeRequiredClassName: function (element) {
    			if (element.className.indexOf(REQUIRED_CELL_CLASS) >= 0) {
    				removeClassName(element, REQUIRED_CELL_CLASS);
    				requiredFields--;
    			}

    			element.children[0].title = "";
    			if (requiredFields == 0) {
    				this._setDisabledStateForGridButtons();
    			}
    		},

    		_setDisabledStateForGridButtons: function () {
    			for (var i = 0; i < elementsToDisable.length; i++) {
    				if (elementsToDisable[i]) {
    					if (requiredFields > 0) {
    						addClassName(elementsToDisable[i], "disabledElement");
    						elementsToDisable[i].disabled = true;
    					}
    					else {
    						removeClassName(elementsToDisable[i], "disabledElement");
    						elementsToDisable[i].disabled = false;
    					}
    				}
    			}
    		},

    		_handleGridCommand: function (sender, args) {
    			var commandName = args.get_commandName();
    			if (commandName == "BatchEdit" && requiredFields > 0) {
    				args.set_cancel(true);
    			}
    		}
    	}
    };


	//Common
    function addClassName(element, className) {
    	if (element.className.indexOf(className) < 0) {
    		element.className = element.className + " " + className;
    	}
    }

    function removeClassName(element, className) {
    	if (element.className.indexOf(className) >= 0) {
    		element.className = element.className.replace(className, "");
    	}
    }

    function findColumnByUniqueName(tableView, uniqueName) {
        var columns = tableView.get_columns();
        for (var i = 0; i < length; i++) {
            //TODO
        }
    }

    function preventEvent(e) {
        var evt = e ? e : window.event;
        if (evt.stopPropagation) evt.stopPropagation();
        if (evt.preventDefault) evt.preventDefault();
        if (evt.cancelBubble != null) evt.cancelBubble = true;
        if (evt.stopImmediatePropagation) evt.stopImmediatePropagation();
        evt.returnValue = false;
    }
})();